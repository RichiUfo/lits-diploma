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
        @date = DateTime.now.getlocal
      end

      def save_source_events(source)
        raw_events(source.ext_id).each do |raw_event|
          event = format_event raw_event.deep_symbolize_keys!

          event[:source_id] = source.id
          event[:city_id]   = source.city_id if event[:city_id].blank?

          event_stored = Event.fb_source.find_by(ext_id: event[:ext_id])

          if event_stored.nil?
            event_status = :created
            event_stored = Event.new event
          else
            event_status = :updated
            event_stored.attributes = event
            # binding.pry
          end

          if event_stored.save
            puts event_stored[:name]
            @report[event_status] += 1
          else
            puts event_stored.errors.full_messages
            @report[:errors] += 1
          end

          break if event[:date] < @date
        end
      end

      # def get_object(object_id)
      #   @graph.get_object(object_id)
      # end

      def format_event(raw_event) # => normalize hash before save
        # binding.pry
        {
          name:        raw_event[:name],
          description: raw_event[:description],
          date:        raw_event[:start_time].to_time.strftime('%a, %d %b %Y %H:%M:%S UTC %:z'),
          picture:     picture(raw_event),
          big_picture: cover(raw_event), # big_picture(raw_event[:id]),
          ext_id:      raw_event[:id].to_i,
          lat:         raw_event.dig(:place, :location, :latitude),
          lng:         raw_event.dig(:place, :location, :longitude),
          address:     raw_event.dig(:place, :location, :street),
          city_id:     city_id_map(raw_event) # raw_event.dig(:place, :location, :city_id)
          ### stubs below
          # reg_ref:      '',
          # organizer_id: '',
          # category_id:  '',
          # price:        '',
          # format_id:    ''
        }
      end

      def picture(raw_event)
        raw_event.dig(:picture, :data, :url)
      end

      def cover(raw_event)
        raw_event.dig(:cover, :source)
      end

      def city_id_map(raw_event)
        ext_city_id = raw_event.dig(:place, :location, :city_id)
        return unless ext_city_id.nil?
        CitySourceType.find_by(ext_id: ext_city_id).try(:city_id)
      end

      def raw_events(event_ext_id)
        fields = %w( description name start_time end_time message
                     from picture.type(large) cover link created_time updated_time
                     place{location{city city_id longitude latitude}})
        @graph.get_connection(event_ext_id, 'events', limit: @limit, fields: fields)
      end
    end
  end
end
