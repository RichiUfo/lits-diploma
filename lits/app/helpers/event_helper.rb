module EventHelper
  MAP_LINK = 'https://maps.googleapis.com/maps/api/staticmap?' \
             'center=<lat>,<lng>&' \
             'size=<width>x<height>&' \
             'zoom=<zoom>&' \
             'markers=color:red|<lat>,<lng>&' \
             'key=<key>'.freeze
  MAP_KEY  = 'AIzaSyDwbSLp-THz0tcCIPo8UiF6LXyAwZrrEak'.freeze
  MAP_ZOOM = 17
  MAP_SIZE = { width: 300, height: 300 }.freeze

  def event_image_map(event)
    return nil if event.lat.nil? || event.lng.nil?

    content_tag(:div, image_tag(mag_image_link(event)), class: 'event-map')
  end

  def mag_image_link(event)
    MAP_LINK.gsub('<key>', MAP_KEY.to_s)
            .gsub('<lat>', event.lat.to_s)
            .gsub('<lng>', event.lng.to_s)
            .gsub('<zoom>', MAP_ZOOM.to_s)
            .gsub('<width>', MAP_SIZE[:width].to_s)
            .gsub('<height>', MAP_SIZE[:height].to_s)
  end

  def event_header(event)
    content_tag :hgroup, class: 'event-header' do
      event_info(event) + event_picture(event)
    end
  end

  def event_body(event)
    content_tag :bgroup, class: 'event-body' do
      event_despripton(event) + event_image_map(event)
    end
  end

  def event_despripton(event)
    if event.description.present?
      content_tag(:article, event.description.html_safe, class: 'event-description')
    else
      ''
    end
  end

  def event_picture(event)
    if event.picture.present?
      content_tag(:div, image_tag(event.picture), class: 'event-picture-wrapper')
    else
      ''
    end
  end

  def event_info(event)
    content_tag :div, class: 'event-info' do
      safe_join [event_title(event),
                 event_time(event) +
                 event_address(event) +
                 event_original(event)]
    end
  end

  def event_title(event)
    content_tag(:h1, event.name, class: 'event-title')
  end

  def event_time(event)
    time_tag(
      event.date,
      I18n.l(event.date.in_time_zone, format: :long),
      class: 'event-date'
    )
  end

  def event_address(event)
    event.address.present? ? content_tag(:p, event.address, class: 'event-address') : ''
  end

  def event_original(event)
    original_link = Components::Link.original_event_url(event.source.source_type, event.ext_id)
    content_tag :p,
                safe_join(
                  ['Оригинал: ',
                   link_to(original_link, original_link, target: :_blank)]
                ),
                class: 'event-original'
  end
end
