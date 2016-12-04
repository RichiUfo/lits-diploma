class FeedController < ApplicationController
  def index
  end

  def edit
  end

  def page_title
    title = Rails.application.config.app_name
    title + if action_name == 'index'
              ' | Ваша лента событий'
            elsif action_name == 'edit'
              ' | Настройка ленты событий'
            else
              ''
            end
  end
end
