module Components
  module Meta
    class Title
      def self.page_title(controller)
        if title_method? controller
          title_method controller
        else
          APP_NAME
        end
      end

      def self.title_method?(controller)
        respond_to? controller.controller_name + '_title'
      end

      def self.title_method(controller)
        send(controller.controller_name + '_title', controller)
      end

      def self.events_title(controller)
        action_name = controller.action_name.to_sym
        title = APP_NAME
        title += GLUE if [:index, :show, :date].include? action_name
        title + if action_name == :index
                  'Все события Одессы'
                elsif action_name == :show
                  controller.event.name
                elsif action_name == :date
                  "События за #{controller.params[:date]}"
                else
                  ''
                end
      end

      def self.feed_title(controller)
        action_name = controller.action_name.to_sym
        title = APP_NAME
        title += GLUE if [:index, :edit].include? action_name
        title + if action_name == :index
                  'Ваша лента событий'
                elsif action_name == :edit
                  'Настройка ленты событий'
                else
                  ''
                end
      end

      def self.search_title(controller)
        action_name = controller.action_name.to_sym
        title = APP_NAME
        title += GLUE if [:search].include? action_name
        title + if action_name == :search
                  "Поиск по #{controller.params[:q]}"
                else
                  ''
                end
      end

      def self.tags_title(controller)
        action_name = controller.action_name.to_sym
        title = APP_NAME
        title += GLUE if [:index, :show].include? action_name
        title + if action_name == :index
                  'Все теги'
                elsif action_name == :show
                  controller.tag.name
                else
                  ''
                end
      end
    end
  end
end
