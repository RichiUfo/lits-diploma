class EventsController < ApplicationController
  def index
    @events = Event.where('date > ?', Time.zone.now)
                   .order('date')
                   .page(@page)
                   .per(20)
  end

  def show
    @event = Event.friendly.find(params[:id])
  end

  def date
    logger.debug(OmniAuth::Strategies.constants)
  end
end
