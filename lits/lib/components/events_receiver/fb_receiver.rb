require 'byebug'
require 'koala'
require 'uri'

module Components
  module EventsReceiver
    class FbReceiver < BaseReceiver
      TOKEN = 'EAAFXQ51xfCkBADECMbksUKObfcgk7qcajFynAWN55B09ZCAvJIjqrcS1DERTNKRcRYUrQuoBa6oVp5elFfZBVgWLwrL0Q
      ZAGB6yUWUreCDEwyOk0p24GpYgH0w5wqZBV1ljf7sjo9v5ZBwUpQ4GKiN1E4pT6yWMIZD'

      def initialize
        super
        @graph = Koala::Facebook::API.new(TOKEN)
      end

      def save_source_events (source)
        events=@graph.get_connections(source.ext_id, 'events')
        events.each do |event|

          event = get_event event
          event[:source_id] = source.id
          event[:city_id] = source.city_id

          event_in_db = Event.fb_source.find_by(ext_id: event[:ext_id].to_i)
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

      def get_event (event)
        process_data(event)
      end

      def process_data(event)
        puts raw_event = {}
        puts raw_event['name'] = event['name']
        puts raw_event['date'] = DateTime.parse(event['start_time']).strftime(" %e %b %Y %H:%M ")
        puts raw_event['address'] = "#{event.try(:[], 'place').try(:[], 'name')}, #{event.try(:[], 'place').try(:[], 'location').try(:[], 'street')}."
        puts raw_event['ext_id'] = event['id']
        raw_event['description'] = event['description']
        puts raw_event['picture'] = @graph.get_picture(event['id'], type: :large)
        puts raw_event['lat'] = event.try(:[], 'place').try(:[], 'location').try(:[], 'latitude')
        puts raw_event['lng'] = event.try(:[], 'place').try(:[], 'location').try(:[], 'longitude')

         {organizer_id: '',
         category_id: '',
         format_id: '',
         price: '',
         name: raw_event['name'],
         description: raw_event['description'],
         date: raw_event['date'],
         picture: raw_event['picture'],
         reg_ref: URI.extract(raw_event['description']),
         ext_id: raw_event['ext_id'],
         lat: raw_event['lat'],
         lng: raw_event['lng'],
         address: raw_event['address']}
      end


    end
  end
end

