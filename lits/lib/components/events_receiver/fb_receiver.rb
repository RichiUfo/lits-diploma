module Components
  module EventsReceiver
    class FbReceiver < BaseReceiver
      require 'koala'

      def initialize
        Koala.config.api_version = 'v2.8'
        @graph = Koala::Facebook::API.new # (oauth_access_token)
      end

      # http://graph.facebook.com/me?access_token=#{your_oauth_token}
      def get_me # => if you can
        @graph.get_object('me')
      end

      def get_object(object_id) # => if you can
        @graph.get_object(object_id)
      end

      def get_raw_event
        client.get_connection('someuser', 'posts', {limit: @options[:max_items],
                                fields: ['message', 'id', 'from', 'type',
                                'picture', 'link', 'created_time', 'updated_time']})
      end

      def get_by_place
        @result = @graph.get_connection('search', type: :place)
        @result.last
      end


    end
  end
end
