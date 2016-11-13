
module Components
  module EventsReceiver
    class VkReceiver < BaseReceiver
      SOURCE_EVENTS_URL = 'https://vk.com/al_groups.php?act=show_events&al=1&oid=-<source_id>'

      def initialize
        super
        @client = VkontakteApi::Client.new
      end

      def save_source_events source
        source_events_ids(source.ext_id).each do |event_ext_id|
          event = get_event event_ext_id
          event[:source_id] = source.id
          event[:city_id] = source.city_id if event[:city_id].blank?

          event_in_db = Event.vk_source.find_by(ext_id: event[:ext_id].to_i)
          save_key = :updated
          
          if event_in_db.nil?
            save_key = :created
            event_in_db = Event.new event
          end

          if event_in_db.save
            @report[save_key] += 1
          else
            puts event_in_db.errors.full_messages
            @report[:errors] += 1
          end

          break if event[:date] < DateTime.now
        end
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
          date: DateTime.strptime(raw_event.start_date,'%s'),
          picture: raw_event.photo_big,
          reg_ref: Components::Link.parse_registration_link(raw_event.description),
          ext_id: raw_event.gid,
          lat: raw_event.try(:place).try(:latitude),
          lng: raw_event.try(:place).try(:longitude),
          address: raw_event.try(:place).try(:address),
          city_id: city_id(raw_event.try(:place).try(:city))
        }
      end

      def source_events_ids source_ext_id
        Net::HTTP.get(URI(source_event_url(source_ext_id)))
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
