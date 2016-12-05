module Components
  module Meta
    class Description
      MAX_DESCRIPTION_LENGTH = 150
      def self.description(controller)
        if description_method? controller
          description = description_method controller
        end

        description ||= APP_DESCRIPTION
      end

      def self.description_method?(controller)
        respond_to? controller.controller_name + '_description'
      end

      def self.description_method(controller)
        send(controller.controller_name + '_description', controller)
      end

      def self.events_description(controller)
        if controller.action_name.to_sym == :show
          text = Nokogiri::HTML.parse(controller.event.description).css('p').first.text
          sentences_before_max_length(text) if text.length > MAX_DESCRIPTION_LENGTH            
        elsif controller.action_name.to_sym == :date
          "Просмотр событий за #{controller.params[:date]} на сайте #{APP_NAME}"
        end
      end

      def self.search_description(controller)
        if controller.action_name.to_sym == :search
          "Поиск '#{controller.params[:q]}' по #{APP_NAME}".html_safe
        end
      end

      def self.tags_description(controller)
        if controller.action_name.to_sym == :index
          "Все теги на сайте #{APP_NAME}"
        elsif controller.action_name.to_sym == :show
          "Все грядущие события по тегу '#{controller.tag.name}' на сайте #{APP_NAME}"
        end
      end

      def self.sentences_before_max_length(text)
        text[0..text.chomp('.').rindex('.', MAX_DESCRIPTION_LENGTH)]
      end
    end
  end
end
