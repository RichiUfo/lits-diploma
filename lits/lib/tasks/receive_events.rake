namespace :receive_events do

  # rake receive_events:run
  task :run => :environment do
    SourceType::NAMES.values.each do |source_type|
      if source_type == :vk
        puts Components::EventsReceiver::ReceiverFactory.load_events_of_source_type(source_type).to_yaml
      end
    end
    
  end  
end
