module EventsHelper
  def events_grid(events)
    content_tag(
      :section, id: 'masonry-container',
                class: 'transitions-enabled centered masonry clearfix'
    ) do
      safe_join events.map { |e| event_col e }
    end
  end

  def event_col(event)
    content_tag :div, event_tpl(event), class: 'box col3'
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
      content_tag(:h5, link_to(event.name, event_url(event))) +
        event_time(event)
    end
  end
end
