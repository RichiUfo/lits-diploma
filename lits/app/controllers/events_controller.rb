class EventsController < ApplicationController
  def index
    @events = [
      Event.new(id: 1, name: 'e1', description: 'd1', date: Date.tomorrow, picture: 'http://www.hor.net.ua/wp-content/uploads/2016/03/%D0%B2%D0%B2%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-2-4.jpg'),
      Event.new(id: 2, name: 'e2', description: 'd2', date: Date.tomorrow, picture: 'http://www.hor.net.ua/wp-content/uploads/2016/03/%D0%B2%D0%B2%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-2-4.jpg'),
      Event.new(id: 3, name: 'e3', description: 'd3', date: Date.tomorrow, picture: 'http://www.hor.net.ua/wp-content/uploads/2016/03/%D0%B2%D0%B2%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-2-4.jpg'),
      Event.new(id: 4, name: 'e4', description: 'd4', date: Date.tomorrow, picture: 'http://www.hor.net.ua/wp-content/uploads/2016/03/%D0%B2%D0%B2%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-2-4.jpg'),
      Event.new(id: 5, name: 'e5', description: 'd5', date: Date.tomorrow, picture: 'http://www.hor.net.ua/wp-content/uploads/2016/03/%D0%B2%D0%B2%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-2-4.jpg'),
      Event.new(id: 6, name: 'e6', description: 'd6', date: Date.tomorrow, picture: 'http://www.hor.net.ua/wp-content/uploads/2016/03/%D0%B2%D0%B2%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-2-4.jpg'),
      Event.new(id: 7, name: 'e7', description: 'd7', date: Date.tomorrow, picture: 'http://www.hor.net.ua/wp-content/uploads/2016/03/%D0%B2%D0%B2%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-2-4.jpg'),
    ]
  end

  def show
    @event = Event.new(id: 1, name: 'e1', description: 'd1', picture: 'http://lorempixel.com/250/200/')
  end

  def date
  end
end
