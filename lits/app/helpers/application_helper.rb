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

  def og_title
    tag :meta, property: 'og:title', content: Components::Meta::Og.title(controller)
  end

  def og_description
    tag :meta, property: 'og:description',
               content: Components::Meta::Og.description(controller)
  end

  def og_image
    tag :meta, property: 'og:image', 
               content: Components::Meta::Og.image(controller)
  end
end
