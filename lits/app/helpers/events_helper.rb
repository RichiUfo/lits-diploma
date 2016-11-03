module EventsHelper

  @@items_per_row_avaliable = [1, 2, 3, 4, 6];

  def events_grid events, items_per_row = 4
    unless @@items_per_row_avaliable.include? items_per_row
      raise "Можно вывести только #{@@items_per_row_avaliable.join(', ')} элементов в строке"
    end

    content_tag :section, class: 'events-grid' do
      [list_start, list_center(events, items_per_row), list_end].join("\n").html_safe
    end
  end

  private

  def list_start
     row_start
  end

  def row_start
    '<div class="row">'
  end

  def col_start items_per_row
    "<div class='col-sm-#{bootstrap_col_index(items_per_row)}'>"
  end

  def list_center events, items_per_row
    rendered = events.map.with_index do |event, key| 
      tpl = col_start(items_per_row) + event_tpl(event) + col_end

      if new_row_starts? key, items_per_row
        tpl = row_end + row_start + tpl
      end

      tpl
    end

    rendered.join("\n")
  end

  def event_tpl event
    content_tag :div, class: 'thumbnail event-thumbnail' do
      link_to(image_tag(event.picture, alt: event.name), event_url(event), class: 'event-thumbnail-link') +
      thumbnail_caption(event)
    end
  end

  def thumbnail_caption event
    content_tag :div, class: 'caption' do
      content_tag(:h3, event.name) +
      content_tag(:time, event.date, class: 'event-date', datetime: event.date) +
      content_tag(:p, event.description, class: 'event-description')
    end    
  end

  def list_end
    row_end
  end

  def col_end
    '</div>'
  end

  def row_end
    '</div>'
  end

  def new_row_starts? key, items_per_row
    key > 0 && key % items_per_row === 0
  end

  def bootstrap_col_index items_per_row
    12 / items_per_row
  end
end
