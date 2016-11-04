require 'nokogiri'

module Components
  module EventsReceiver
    class DouReceiver < BaseReceiver
      SOURCE_EVENTS_URL = URI('https://dou.ua/calendar/feed/%D0%B2%D1%81%D0%B5%20%D1%82%D0%B5%D0%BC%D1%8B%2F%D0%9E%D0%B4%D0%B5%D1%81%D1%81%D0%B0')

      attr_reader

      def self.run
        @dou_reader ||= new
        @dou_reader.process_data
      end

      def initialize
        @data = {}
        fetch_data_from_xml
      end

      def process_data
        raw_events = @data['rss']['channel']['item']
        raw_events.each do |e|
          raw_event = {}
          raw_event['title'] = e['title']
          # raw_event["city"],
          raw_event['address'] = get_event_date_time_adress e['description'].lines.first

          p raw_event['address']
          # p e["description"].lines.first
        end
      end

      def prepare_event(raw_event)
        {
          city_id:      city_id,
          organizer_id: '',
          category_id:  '',
          source_id:    '',
          format_id:    '',
          date:         '',
          price:        '',
          coordinates:  '',
          ext_id:       '',
          name:         raw_event['title'],
          picture:      '',
          description:  '',
          address:      '',
          reg_ref:      ''
        }
      end

      def save_event(prepared_event)
        Event.Create prepared_event
      end

      protected

      def fetch_data_from_xml
        # @data = Hash.from_xml(Net::HTTP.get(SOURCE_EVENTS_URL))
        @data = Hash.from_xml(Rails.root.join('lib', 'components', 'events_receiver', 'debug_xml.xml'), &:read)
      end

      def city_id(city_strind)
        city_name = city_strind.split(',')[0]
        city = City.find_by(name: city_name)
        city.present? ? city.id : nil
      end

      def get_event_date_time_adress(html_string)
        @first_string = Nokogiri::HTML(html_string)
        @first_string.children.children.children.children.children[8]
        # adr_parts = full_adress.split("")
        @first_string.nil? ? '' : prepare_date_time_adress(@first_string.content)
      end

      def prepare_date_time_adress(string)
        words = ['Время:', 'Час:', 'Место:', 'Місце:']
        words.each do |word|
          string.gsub!(word, "#{word}\n") unless string.index(word).nil?
        end
        string
      end
    end
  end
end
