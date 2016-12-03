class CategoriesController < ApplicationController
  
  def show
    @events = Event.future.by_tag(@tag).page(@page)
    @event = Event.where(category_id: params[:category_id])
  end

end
