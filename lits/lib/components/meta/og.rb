module Components
  module Meta
    class Og
      DEFAULT_OG_IMAGE = 'odessa.jpg'
      
      def self.title(controller)
        Title.title(controller)
      end
      
      def self.description(controller)
        Description.description(controller)
      end

      def self.image(controller)
        if event_page?(controller)
          controller.event.picture
        else
          controller.request.original_url + DEFAULT_OG_IMAGE
        end
      end

      def self.event_page?(controller)
        controller.controller_name == 'events' && controller.action_name == 'show'
      end
    end
  end
end
