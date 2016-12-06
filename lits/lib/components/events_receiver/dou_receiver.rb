require 'nokogiri'

module Components
  module EventsReceiver
    class DouReceiver < BaseReceiver
      SOURCE_EVENTS_URL = URI('https://dou.ua/calendar/feed/%D0%B2%D1%81%D0%B5%20%D1%82%D0%B5%D0%BC%D1%8B%2F%D0%9E%D0%B4%D0%B5%D1%81%D1%81%D0%B0')
      attr_reader :data
      # Components::EventsReceiver::DouReceiver.run
      def save_source_events(source = nil)
        fetch_data_from_xml(source)
        process_data(source)
      end

      def initialize
        super
        @data = {}
      end

      def process_data(source)
        raw_events = @data['rss']['channel']['item']
        raw_events.each do |e|
          raw_event = {}
          raw_event['title']       = e['title']
          raw_event['date'],
          raw_event['address']     = get_event_date_time_adress(e['description'].lines.first)
          raw_event['ext_id']      = e['guid'].split('/').last
          raw_event['description'] = prepare_description(e['description'])
          raw_event['image']       = get_image(e['description'].lines.first)
          raw_event['source']      = source
          raw_event['lat'],
          raw_event['lng']         = Components::Geocode.get_coordinates_by_address(raw_event['address'])
          save_event(prepare_event(raw_event))
        end
      end

      def prepare_event(raw_event)
        {
          city_id:      city_id(raw_event['address'].split(',')[0]),
          organizer_id: '',
          category_id:  '',
          source_id:    raw_event['source'].id,
          format_id:    '',
          date:         prepare_date(raw_event['date']),
          price:        '',
          lat:          raw_event['lat'],
          lng:          raw_event['lng'],
          ext_id:       raw_event['ext_id'],
          name:         raw_event['title'],
          picture:      raw_event['image'],
          description:  raw_event['description'],
          address:      raw_event['address'],
          reg_ref:      ''
        }
      end

      def save_event(prepared_event)
        event_in_db = Event.dou_source.find_by(ext_id: prepared_event[:ext_id])
        save_key = :updated
        if event_in_db.nil?
          save_key = :created
          event_in_db = Event.new prepared_event
        else
          event_in_db.attributes = prepared_event
        end

        if event_in_db.save
          @report[save_key] += 1
          save_event_tags(event_in_db)
        else
          p event_in_db.errors.full_messages
          @report[:errors] += 1
        end
      end

      def save_event_tags(event)
        tags = get_tags(event.source.source_type, event.ext_id)
        db_tags = []
        tags.each do |tag_name|
          tag_in_db = Tag.find_by(name: tag_name)
          db_tags << if tag_in_db.nil?
                       { tag: Tag.create(name: tag_name), event: event }
                     else
                       { tag: tag_in_db, event: event }
                     end
        end
        EventTag.by_event(event).destroy_all
        EventTag.create(db_tags)
      end

      def fetch_data_from_xml(source)
        @data = Hash.from_xml(Net::HTTP.get(source.nil? ? SOURCE_EVENTS_URL : URI(source.ref)))
        # @data = Hash.from_xml(File.open(Rails.root.join('public', 'dou.xml').to_s, &:read))
      end

      protected

      def city_id(city_strind)
        city_name = city_strind.split(',')[0]
        city = City.find_by(name: city_name)
        city.present? ? city.id : nil
      end

      def get_event_date_time_adress(html_string)
        @first_string = Nokogiri::HTML(html_string)
        @first_string.search('a').remove
        @first_string.nil? ? '' : prepare_date_time_adress(@first_string.content)
      end

      def get_image(html_string)
        @first_string = Nokogiri::HTML(html_string)
        img = @first_string.search('img').attribute('src').value
        img.nil? ? '' : img
      end

      def prepare_date_time_adress(string)
        words = { 'Дата:' => 'date:',
                  'Время:' => "\ntime:",
                  'Час:' => "\ntime:",
                  'Начало:' => "\nstart:",
                  'Початок:' => "\nstart:",
                  'Место:' => "\nplace:",
                  'Місце:' => "\nplace:" }
        words.each do |key, value|
          string.gsub!(key, value) unless string.index(key).nil?
        end
        hash = {}
        string.lines.each do |k_v|
          split = k_v.sub(':', "\n").lines
          hash[split[0].strip] = split[1].strip
        end
        return { date: hash['date'], start: hash['start'], time: hash['time'] },
               hash['place']
      end

      def prepare_date(hash)
        string_date = hash[:date]
        string_time = if hash[:start].nil? && hash[:time].nil?
                        '00:00'
                      else
                        hash[:start].nil? ? hash[:time].split('—')[0] : hash[:start]
                      end
        date_parts = string_date.split(' ')
        date_parts[1] = date_parts[1].split('(')[0].strip
        current_date = Time.zone.now.to_date
        day = date_parts[0].to_i
        month, year = convert_month(date_parts)
        year = year.nil? ? current_date.year : year.to_i
        arr_time = string_time.split(':')
        hh, mm = arr_time[0].to_i, arr_time[1].to_i
        tz = Time.zone.now.to_s.split(' ').last
        DateTime.new(year, month, day, hh, mm, 0, tz)
      end

      def convert_month(date_parts)
        string_month = date_parts.last.split(' ').first
        string_year  = date_parts.last.split(' ').last
        months_r = %w(января февраля марта апреля мая июня июля августа сентября октября ноября декабря)
        months_u = %w(січня лютого березня квітня травня червня липня серпня вересня жовтня листопада грудня)
        index = if months_r.index(string_month.strip).nil?
                  months_u.index(string_month.strip)
                else
                  months_r.index(string_month.strip)
                end
        return (index.nil? ? 1 : index + 1), (string_month == string_year ? nil : string_year)
      end

      def prepare_description(html)
        "<div>#{html.lines[2..-1].join}"
      end

      def get_tags(source_type, ext_id)
        original_link = Components::Link.original_event_url(source_type, ext_id)
        doc = Nokogiri::HTML(Net::HTTP.get(URI(original_link)))
        string = doc.search('.b-post-tags').text
        string.empty? ? ['прочее'] : string.lines[2].strip.split(', ')
      end
    end
  end
end
