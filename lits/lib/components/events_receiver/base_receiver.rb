require 'net/http'
require 'singleton'

module Components
  module EventsReceiver
    class BaseReceiver
      include Singleton

      attr_reader :report

      def initialize
        @report = {
          created: 0,
          updated: 0,
          errors: 0
        }
        @today = DateTime.now.in_time_zone
      end

      def source_events_ids(source_ext_id)
        self.class.no_method __method__.to_s
      end

      def get_event(event_ext_id)
        self.class.no_method __method__.to_s
      end

      def format_event(raw_event)
        self.class.no_method __method__.to_s
      end

      def get_raw_event(event_ext_id)
        self.class.no_method __method__.to_s
      end

      def self.no_method(method_name)
        raise MethodNotImplementedError.new 'You need to implement ' + method_name + ' in your class'
      end
    end

    class MethodNotImplementedError < NoMethodError; end
  end
end
