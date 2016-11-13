class EventsController < ApplicationController
  def index
    @events = Event.where('date > ?', DateTime.now).order('date').all 
  end

  def show
    @event = Event.find(params[:id])
  end

  def date
  end
end
