module ApplicationHelper
  APP_NAME = Rails.application.config.app_name

  def container(content_or_classes = nil, classes = '', &block)
    if block_given?
      content_tag :div, capture(&block), class: "container #{content_or_classes}"
    else
      content_tag :div, content_or_classes, class: "container #{classes}"
    end
  end

  def fa(icon_name)
    content_tag :i, '', class: "fa fa-#{icon_name}"
  end

  def on_top_button
    content_tag :div, fa('arrow-up'), id: 'on-top-button'
  end

  def site_title
    content_tag :title, Components::Meta::Title.title(controller)
  end

  def meta_description
    tag :meta, name: :description, 
               content: Components::Meta::Description.description(controller)
  end

  def meta_viewport
    tag :meta, name: :viewport, content: 'width=device-width, initial-scale=1.0'
  end
end
