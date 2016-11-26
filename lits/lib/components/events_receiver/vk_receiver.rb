module Components
  module EventsReceiver
    class VkReceiver < BaseReceiver
      SOURCE_EVENTS_URL = 'https://vk.com/al_groups.php' \
                          '?act=show_events&al=1&oid=-<source_id>'.freeze

      def initialize
        super
        @client = VkontakteApi::Client.new
      end

      def save_source_events(source)
        source_events_ids(source.ext_id).each do |event_ext_id|
          event = get_event event_ext_id, source
          event_in_db = Event.vk_source.find_by(ext_id: event[:ext_id].to_i) || Event.new(event)
          event_in_db.save

          update_report(event_in_db)

          break if event[:date] < Time.in_time_zone
        end
      end

      def get_event(event_ext_id, source)
        raw_event = get_raw_event(event_ext_id)
        raw_fixed_post = get_raw_fixed_post(raw_event)

        event = format_event(raw_event).merge format_fixed_post(raw_fixed_post)
        fill_missings_with_source event, source
      end

      def get_raw_event(event_ext_id)
        @client
          .groups
          .getById(
            gid: event_ext_id,
            fields: %w(city country place description wiki_page start_date finish_date activity
                       status contacts links fixed_post verified site)
          )
          .last
      end

      def get_raw_fixed_post(raw_event)
        return nil unless raw_event.try(:fixed_post)

        @client.wall
               .getById(posts: "-#{raw_event[:gid]}_#{raw_event[:fixed_post]}")
               .first
      end

      def format_event(raw_event)
        {
          name: raw_event.name,
          description: raw_event.description,
          date: DateTime.strptime(raw_event.start_date, '%s'),
          picture: raw_event.photo_big,
          reg_ref: Components::Link.parse_registration_link(raw_event.description),
          ext_id: raw_event.gid,
          lat: raw_event.try(:place).try(:latitude),
          lng: raw_event.try(:place).try(:longitude),
          address: raw_event.try(:place).try(:address),
          city_id: city_id(raw_event.try(:place).try(:city))
        }
      end

      def format_fixed_post(raw_fixed_post)
        fixed_post = {}
        big_picture = picture_from_fixed_post raw_fixed_post

        fixed_post[:description] = raw_fixed_post.text if raw_fixed_post.text.present?
        fixed_post[:big_picture] = big_picture if big_picture.present?

        fixed_post
      end

      def fill_missings_with_source(event, source)
        event[:source_id] = source.id
        event[:city_id]   = source.city_id if event[:city_id].blank?
        event
      end

      def picture_from_fixed_post(raw_fixed_post)
        picture = raw_fixed_post.try(:attachment).try(:photo)
        picture.try(:src_xxbig) || picture.try(:src_xbig) || picture.try(:src) if picture.present?
      end

      def source_events_ids(source_ext_id)
        Net::HTTP
          .get(URI(source_event_url(source_ext_id)))
          .scan(/id="public_event_cell([0-9]+)"/)
          .map { |e| e.first.to_i }
          .select(&:positive?)
      end

      def source_event_url(sourse_ext_id)
        self.class::SOURCE_EVENTS_URL.sub '<source_id>', sourse_ext_id.to_s
      end

      private

      def city_id(ext_city_id)
        city_source_type = CitySourceType.find_by(
          ext_id: ext_city_id,
          source_type_id: SourceType::KEYS[:vk]
        )
        city_source_type.present? ? city_source_type.city_id : nil
      end

      def update_report(item)
        if item.has_errors?
          @report[:errors] += 1
        else
          @report[item.id_changed? ? :exists : :created] += 1
        end
      end
    end
  end
end
