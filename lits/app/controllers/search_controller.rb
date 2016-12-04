class SearchController < ApplicationController
  before_action :redirect_on_empty_q, only: [:index, :search]

  def index
    redirect_to search_query_path(q: params[:q].downcase)
  end

  def search
    @events = Event.search(params[:q])
  end

  def redirect_on_empty_q
    redirect_back(fallback_location: root_path) unless params.key?(:q) && params[:q].present?
  end

  def page_title
    title = Rails.application.config.app_name
    title + if action_name == 'search'
              " | Поиск по #{params[:q]}"
            else
              ''
            end
  end
end
