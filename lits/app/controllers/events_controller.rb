class EventsController < ApplicationController
  def index
    @events = Event.future(current_user).page(@page)
  end

  def show
    @event = Event.friendly.find(params[:id])
  end

  def date
    @events = Event.by_day(params[:date]).page(@page)
  end
end
