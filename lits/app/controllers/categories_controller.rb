class CategoriesController < ApplicationController
  def show
    @events = Event.future.by_category(params[:category_id]).page(@page)
  end
end
