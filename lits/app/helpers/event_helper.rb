module EventHelper
  
  UNDER_HEADER_RATIO = 1.5

  def event_header event
    picture_tag = if event.picture.present? 
                    content_tag(:div, image_tag(event.picture), class: 'event-picture-wrapper') 
                  else 
                    ''
                  end

    content_tag :hgroup, content_tag(:h1, event.name) + picture_tag, class: 'event-header'
  end

  private 


  def picture_under_header? width, height 
    width > height && (width.to_f / height.to_f) >= UNDER_HEADER_RATIO
  end
end
