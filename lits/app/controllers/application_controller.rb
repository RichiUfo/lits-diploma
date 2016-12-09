class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_page
  before_action :set_raven_context

  def set_page
    @page = params[:page].present? ? params[:page] : 1
  end

  def set_raven_context
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
