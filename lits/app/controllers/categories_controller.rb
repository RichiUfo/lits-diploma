class CategoriesController < ApplicationController
  def index
    @events = Event.order(date: :asc)
                   .page(@page)
                   .where.not(category_id: nil)
                   .first(10)
  end

  def show
    @event = Event.where(category_id: params[:category_id])
  end

  def date
    logger.debug(OmniAuth::Strategies.constants)
  end
end
