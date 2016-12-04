class EventsController < ApplicationController
  def index
    @events = Event.future.page(@page)
  end

  def show
    @event = Event.friendly.find(params[:id])
  end

  def date
    @events = Event.by_day(params[:date]).page(@page)
  end
end
