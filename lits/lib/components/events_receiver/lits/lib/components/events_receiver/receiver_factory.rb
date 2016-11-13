module Components
  module EventsReceiver
    class ReceiverFactory
      def self.source_receiver source_type_name
        if SourceType::KEYS[source_type_name.downcase.to_sym].blank?
          raise ArgumentError, "Source type with id #{source_type_name} doesnt exist" 
        end

        receiver_class_name = self.name.sub('ReceiverFactory', source_type_name.capitalize.to_s + 'Receiver')
        receiver_class_name.constantize.instance
      end

      def self.load_events_of_source_type source_type_name
        receiver = source_receiver source_type_name
        sources  = Source.where(source_type_id: SourceType::KEYS[source_type_name.downcase.to_sym]).all

        sources.each do |source|
          receiver.save_source_events source
        end

        receiver.report
      end 
    end
  end
end
