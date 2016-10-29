module Components
  module EventsReceiver
    class VkReceiver < BaseReceiver
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
          city_id: get_city_id(raw_event.place.city),
          reg_ref: Components::Link.parse_registration_link(raw_event.description),
          ext_id: raw_event.gid
        }
      end

      private 

      def get_city_id ext_city_id
        city = City.find_by_vk_id ext_city_id
        city.present? ? city.id : nil
      end
    end
  end
end
