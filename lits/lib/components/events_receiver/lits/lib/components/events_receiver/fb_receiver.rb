require 'byebug'
require 'koala'
require 'uri'

module Components
    module EventsReceiver
        class FbReceiver < BaseReceiver
            TOKEN = 'EAAFXQ51xfCkBACb45DMuvSDHMTrj5UMMdKASPg9VHAS76aZC6FUL0xX0fraC2TV1NaZAgEodfb53yXHJAkVD3AqNpnZCvoFU6qcHbJT2ui112r85giKEpZAv2KQv7Yzl0QUprVhuJN2ZBPSiD9Uhl0OJTNEJmUsjtqklOnTJOOAZDZD'.freeze

            def initialize
                super
                @graph = Koala::Facebook::API.new(TOKEN)
            end

            def save_source_events(source)
                process_data(source.ext_id, source.city_id)
        end

            def process_data(source, city_id)
                event = @graph.get_object(source)[source]

                raw_event = {}
                raw_event['name']      = event['name']
                raw_event['date']      = event['start_time']
                raw_event['address'] = "#{(event['venue']['city'])}, #{(event['venue']['street'])}."
                raw_event['ext_id']      = source
                raw_event['description'] = event['description']
                raw_event['picture'] = ''
                raw_event['source'] = source
                raw_event['lat'] = event['venue']['latitude']
                raw_event['lng'] = event['venue']['longitude']
                save_event(prepare_event(raw_event, city_id))
                   end

            def prepare_event(raw_event, city_id) {
                source_id:    raw_event['source'],
                organizer_id: '',
                category_id:  '',
                format_id:    '',
                price:        '',
                name: raw_event['name'],
                description: raw_event['description'],
                date: raw_event['start_time'],
                picture: raw_event['picture'],
                reg_ref: URI.extract(raw_event['description']),
                ext_id: raw_event['ext_id'],
                lat: raw_event['lat'],
                lng: raw_event['lng'],
                address: raw_event['address'],
                city_id: city_id

            }
            end

            def save_event(prepared_event)
                event_in_db = Event.fb_source.find_by(ext_id: prepared_event[:ext_id])
                save_key = :updated
                if event_in_db.nil?
                    save_key = :created
                    event_in_db = Event.new prepared_event
                end

                if event_in_db.save
                    @report[save_key] += 1

                else
                    p event_in_db.errors.full_messages
                    @report[:errors] += 1
                end
              end

            #
            # rescue ExceptionName
            #
            # end
            #             private
            #
            #             def city_id(ext_city_id)
            #                 city = City.find_by_fb_id ext_city_id
            #                 city.present? ? city.id : nil
            #             end
            #
            #
            #             name: raw_event[raw_event]['name'],
            #             description: raw_event[raw_event]['description'],
            #             date: raw_event[raw_event]['start_time'],
            #             picture: '',
            #             reg_ref: URI.extract((raw_event[raw_event]['description'])),
            #             ext_id: raw_event[raw_event].join,
            #             lat: raw_event[raw_event]['venue']['latitude'],
            #             lng: raw_event[raw_event]['venue']['longitude'],
            #             address: "#{(raw_event[raw_event]['venue']['city'])}, #{(raw_event['raw_event']['venue']['street'])}.",
            #             city_id: city_id(raw_event[raw_event]['venue']['city'])
        end
    end
  end
