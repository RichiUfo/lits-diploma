module Components
  module Meta
    class Description
      MAX_DESCRIPTION_LENGTH = 150
      def self.description(controller)
        if description_method? controller
          description = description_method controller
        end

        description || APP_DESCRIPTION
      end

      def self.description_method?(controller)
        respond_to? controller.controller_name + '_description'
      end

      def self.description_method(controller)
        send(controller.controller_name + '_description', controller)
      end

      def self.events_description(controller)
        if controller.action_name.to_sym == :show
          return controller.event.name if controller.event.description.empty?
          text = first_p controller.event.description
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

      def self.first_p(text)
        paragraph = Nokogiri::HTML.parse(text).css('p').first
        paragraph.present? ? paragraph.text : ''
      end

      def self.sentences_before_max_length(text)
        text.chomp!('.')
        dot_cut_position = text.rindex('.', MAX_DESCRIPTION_LENGTH)
        br_cut_position = text.rindex(%r{</{0,1} {0,1}br>}, MAX_DESCRIPTION_LENGTH)
        space_cut_position = text.rindex(' ', MAX_DESCRIPTION_LENGTH) - 1

        if dot_cut_position
          text[0..dot_cut_position]
        elsif br_cut_position
          text[0..br_cut_position]
        else
          text[0..space_cut_position] + '...'
        end
      end
    end
  end
end
