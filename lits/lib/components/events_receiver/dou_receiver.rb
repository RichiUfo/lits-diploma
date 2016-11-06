require 'nokogiri'

module Components
  module EventsReceiver
    class DouReceiver < BaseReceiver
      SOURCE_EVENTS_URL = URI('https://dou.ua/calendar/feed/%D0%B2%D1%81%D0%B5%20%D1%82%D0%B5%D0%BC%D1%8B%2F%D0%9E%D0%B4%D0%B5%D1%81%D1%81%D0%B0')

      attr_reader :data
      # Components::EventsReceiver::DouReceiver.run
      def save_source_events(url = '')
        fetch_data_from_xml(url)
        process_data
      end

      def initialize
        @data = {}
      end

      def process_data
        raw_events = @data['rss']['channel']['item']
        raw_events.each do |e|
          raw_event = {}
          raw_event['title'] = e['title']
          raw_event['date'],
          raw_event['address'] = get_event_date_time_adress(e['description'].lines.first)
          raw_event['ext_id'] = e['guid']
          raw_event['description'] = Nokogiri::HTML(e['description']).text
          raw_event['image'] = get_image(e['description'].lines.first)
          save_event(prepare_event(raw_event))
        end
      end

      def prepare_event(raw_event)
        {
          city_id:      city_id(raw_event['address'].split(',')[0]),
          organizer_id: '',
          category_id:  '',
          source_id:    '',
          format_id:    '',
          date:         prepare_date(raw_event['date']),
          price:        '',
          coordinates:  '',
          ext_id:       raw_event['ext_id'],
          name:         raw_event['title'],
          picture:      raw_event['image'],
          description:  raw_event['description'],
          address:      raw_event['address'],
          reg_ref:      ''
        }
      end

      def save_event(prepared_event)
        event_in_db = Event.dou_source.find_by(ext_id: prepared_event['ext_id'])
        save_key = :updated
        if event_in_db.nil?
          save_key = :created
          event_in_db = Event.new prepared_event
        end

        if event_in_db.save
          @report[save_key] += 1
        else
          puts event_in_db.errors.full_messages
          @report[:errors] += 1
        end
      end

      protected

      def fetch_data_from_xml(url)
        @data = Hash.from_xml(Net::HTTP.get(url.empty? ? SOURCE_EVENTS_URL : URI(URL)))
        # @data = Hash.from_xml(Rails.root.join('lib', 'components', 'events_receiver', 'debug_xml.xml'), &:read)
      end

      def city_id(city_strind)
        city_name = city_strind.split(',')[0]
        city = City.find_by(name: city_name)
        city.present? ? city.id : nil
      end

      def get_event_date_time_adress(html_string)
        @first_string = Nokogiri::HTML(html_string)
        @first_string.children.children.children.children.children[8]
        @first_string.nil? ? '' : prepare_date_time_adress(@first_string.content)
      end

      def get_image(html_string)
        @first_string = Nokogiri::HTML(html_string)
        img = @first_string.search("img").attribute("src").value
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
        return hash['date'],
               hash['place']
      end

      def prepare_date(strind_date)
        date_parts = strind_date.split(' ')
        date_parts[1] = date_parts[1].split('(')[0].strip
        current_date = Time.current.to_date
        day = date_parts[0].to_i
        month = convert_month(date_parts[1])
        year = month > current_date.mon ? current_date.year + 1 : current_date.year
        Date.new(year, month, day)
      end

      def convert_month(string_month)
        months_r = %w(января февраля марта апреля мая июня июля августа сентября октября ноября декабря)
        months_u = %w(січня лютого березня квітня травня червня липня серпня вересня жовтня листопада грудня)
        index = if months_r.index(string_month.strip).nil?
                  months_u.index(string_month.strip)
                else
                  months_r.index(string_month.strip)
                end
        index + 1
      end
    end
  end
end
