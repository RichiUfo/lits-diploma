class EventsController < ApplicationController
  def index
    @events = Event.future.page(@page)
  end

  def show
    @event = Event.friendly.find(params[:id])
  end

  def date
    logger.debug(OmniAuth::Strategies.constants)
  end
end
