module Components
  module EventsReceiver
    class FbReceiver < BaseReceiver
      require 'koala'

      def initialize
        super
        Koala.config.api_version = 'v2.8'
        oauth = Koala::Facebook::OAuth.new
        @limit = 100 # => only 10 events per fb source
        @graph = Koala::Facebook::API.new(oauth.get_app_access_token)
      end

      def save_source_events(source)
        raw_events(source.ext_id).each do |raw_event|
          event = format_event raw_event
          event[:source_id] = source.id
          event[:city_id] = source.city_id if event[:city_id].blank?

          event_in_db = Event.fb_source.find_by(ext_id: event[:ext_id].to_i)
          event_status = :updated

          if event_in_db.nil?
            event_status = :created
            event_in_db = Event.new event
          end

          if event_in_db.save
            @report[event_status] += 1
          else
            puts event_in_db.errors.full_messages
            @report[:errors] += 1
          end

          break if event[:date] < DateTime.now
        end
      end

      # def get_object(object_id)
      #   @graph.get_object(object_id)
      # end

      def format_event raw_event # => normalize hash before save
        {
          name:        raw_event['name'],
          description: raw_event['description'],
          date:        raw_event['start_time'].to_time.strftime('%a, %d %b %Y %H:%M:%S UTC %:z'),
          picture:     big_picture(raw_event['id']),
          ext_id:      raw_event['id'],
          # coordinates: '', # {}"#{raw_event.try(:place).try(:latitude)} #{raw_event.try(:place).try(:longitude)}",
          lat: raw_event.dig('place', 'location', 'latitude'),
          lng: raw_event.dig('place', 'location', 'longitude'),
          address:     raw_event.dig('place', 'location', 'street'),
          ### stubs below
          city_id:      '1', # city_id(raw_event.try(:place).try(:city))
          reg_ref:      '', # => Components::Link.parse_registration_link(raw_event.description),
          organizer_id: '',
          category_id:  '',
          price:        '',
          source_id:    '',
          format_id:    ''
        }
      end

      #   fields: ['city', 'country', 'place', 'description', 'wiki_page', 'start_date', 'finish_date',
      #           'activity', 'status', 'contacts', 'links', 'fixed_post', 'verified', 'site']

      def big_picture(id)
        @graph.get_picture_data(id, type: :large).dig('data', 'url')
      end

      def raw_events(event_ext_id)
        fields = %w( description name start_time end_time message id place
                     from type picture full_picture link created_time updated_time)
        @graph.get_connection(event_ext_id, 'events', limit: @limit, fields: fields)
      end

      # def get_raw_event2(group)
      #   @graph.get_connection( group, 'events', { fields: ['message', 'id', 'from', 'type',
      #                           'picture', 'link', 'created_time', 'updated_time']})
      # end
    end
  end
end
