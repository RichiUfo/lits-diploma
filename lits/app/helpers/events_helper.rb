module EventsHelper
  ON_EMPTY_MESSAGE = 'Извините, мы не нашли события :('.freeze

  def events_grid(events, on_empty_message = false)
    !events.empty? ? grid(events) : on_empty(on_empty_message || ON_EMPTY_MESSAGE)
  end

  def grid(events)
    content_tag(
      :section, id: 'masonry-container',
                class: 'transitions-enabled centered masonry clearfix'
    ) do
      safe_join events.map { |e| event_col e }
    end
  end

  def on_empty(on_empty_message)
    content_tag :p, on_empty_message, class: 'on-empty-message'
  end

  def event_col(event)
    content_tag :div, event_tpl(event), class: 'box col4'
  end

  private

  def event_tpl(event)
    content_tag :div, class: 'thumbnail event-thumbnail' do
      link_to(
        image_tag(event.picture, alt: event.name),
        event_url(event),
        class: 'event-thumbnail-link'
      ) + thumbnail_caption(event)
    end
  end

  def thumbnail_caption(event)
    content_tag :div, class: 'caption' do
      content_tag(:h5, link_to(event.name.html_safe, event_url(event))) +
        event_time(event)
    end
  end
end
