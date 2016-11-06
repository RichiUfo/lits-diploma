namespace :receive_events do

  # rake receive_events:run
  task :run => :environment do
    SourceType::KEYS.keys.each do |source_type|
      if source_type == :vk || source_type == :dou
        puts Components::EventsReceiver::ReceiverFactory.load_events_of_source_type(source_type).to_yaml
      end
    end

  end
end
