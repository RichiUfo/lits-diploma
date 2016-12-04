module EventsTimelineHelper
  DAYS_COUNT = 20

  def events_timeline
    content_tag :section, id: 'events-timeline', class: 'events-timeline' do
      safe_join(future_days.map do |day|
        link_to day.strftime('%e'),
                events_date_events_path(date: day.strftime('%F')),
                link_options_for_day(day)
      end)
    end
  end

  private

  def future_days
    Time.zone.today..(Time.zone.today + DAYS_COUNT)
  end

  def link_options_for_day(day)
    options = { class: 'events-timeline-day' }
    options[:class] += ' selected' if selected_day?(day)
    options[:class] += ' weekend' if weekend?(day)
    options[:data] = { month: day.strftime('%B') } if day.strftime('%-d') == '1'
    options
  end

  def selected_day?(day)
    params[:date].present? ? params[:date].to_date == day : Time.zone.today == day
  end

  def weekend?(day)
    day.saturday? || day.sunday?
  end
end
