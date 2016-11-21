class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_page

  def set_page
    @page = params[:page].present? ? params[:page] : 1
  end
end
