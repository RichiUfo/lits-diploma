class EventsController < ApplicationController
  attr_reader :event

  def index
    @events = Event.by_user(current_user).future.page(@page)
    @events = Event.future.page(@page) if @events.blank?
  end

  def show
    @event = Event.friendly.find(params[:id])
  end

  def date
    @events = Event.by_day(params[:date]).page(@page)
  end
end
