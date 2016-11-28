module SidenavHelper
  def pusher
    content_tag(:div, class: :pusher) { yield }
  end

  def sidenav
    content_tag(:nav, class: 'ui sidebar vertical menu') { yield }
  end
end
