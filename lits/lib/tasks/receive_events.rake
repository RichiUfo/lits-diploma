namespace :receive_events do
  # rake receive_events:run
  task run: :environment do
    SourceType::KEYS.keys.each do |source_type|
      begin
        puts Components::EventsReceiver::ReceiverFactory
          .load_events_of_source_type(source_type)
          .to_yaml
      rescue StandardError => e
        puts e.message
      end
    end
  end
end
