module EventHelper
  
  UNDER_HEADER_RATIO = 1.5

  def event_header event
    content_tag :hgroup, class: 'event-header' do
       event_info(event) + event_picture(event)
    end
  end

  def event_despripton event
    if event.description.present?
      content_tag(:article, event.description.html_safe, class: 'event-description')
    else
      ''
    end 
  end

  def event_picture event 
    if event.picture.present? 
      content_tag(:div, image_tag(event.picture), class: 'event-picture-wrapper') 
    else 
      ''
    end
  end

  def event_info event
    content_tag :div, class: 'event-info' do
      event_title(event) + event_time(event) + event_address(event) + event_original(event)
    end
  end

  def event_title event
    content_tag(:h1, event.name, class: 'event-title')
  end

  def event_time event
    time_tag event.date, I18n.l(event.date.to_time, :format => :long), class: 'event-date'
  end

  def event_address event
    event.address.present? ? content_tag(:p, event.address, class: 'event-address') : ''
  end

  def event_original event
    original_link = Components::Link.original_event_url(event.source.source_type, event.ext_id)
    content_tag :p, 
                "Оригинал: #{link_to(original_link, original_link, target: :_blank)}".html_safe, 
                class: 'event-original'
  end
end
