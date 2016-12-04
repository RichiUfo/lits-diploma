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

  def page_title
    title = Rails.application.config.app_name
    title + if action_name == 'index'
              ' | Все события Одессы'
            elsif action_name == 'show'
              " | #{@event.name}"
            elsif action_name == 'date'
              " | События за #{params[:date]}"
            else
              ''
            end
  end
end
