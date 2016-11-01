require 'net/http'

module Components
  module EventsReceiver
    class VkReceiver < BaseReceiver
      SOURCE_EVENTS_URL = 'https://vk.com/al_groups.php?act=show_events&al=1&oid=-<source_id>'

      def initialize
        @client = VkontakteApi::Client.new
      end

      def get_event event_ext_id
        format_event get_raw_event(event_ext_id)
      end

      def get_raw_event event_ext_id
        @client.groups.getById(
          gid: event_ext_id, 
          fields: ['city', 'country', 'place', 'description', 'wiki_page', 'start_date', 'finish_date', 
                  'activity', 'status', 'contacts', 'links', 'fixed_post', 'verified', 'site']).last
      end

      def format_event raw_event
        {
          name: raw_event.name,
          description: raw_event.description,
          date: raw_event.start_date,
          picture: raw_event.photo_big,
          coordinates: "#{raw_event.place.latitude} #{raw_event.place.longitude}",
          address: raw_event.place.address,
          city_id: city_id(raw_event.place.city),
          reg_ref: Components::Link.parse_registration_link(raw_event.description),
          ext_id: raw_event.gid
        }
      end

      def source_events_ids sourse_ext_id
        Net::HTTP.get(URI(source_event_url(sourse_ext_id)))
          .scan(/id="public_event_cell([0-9]+)"/)
          .map { |e| e.first.to_i }
          .select{ |e| e > 0 }
      end

      def source_event_url sourse_ext_id
        self.class::SOURCE_EVENTS_URL.sub '<source_id>', sourse_ext_id.to_s
      end
      
      private 

      def city_id ext_city_id
        city = City.find_by_vk_id ext_city_id
        city.present? ? city.id : nil
      end

    end
  end
end
