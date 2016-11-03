module ApplicationHelper
  def container content_or_classes = nil, classes = '', &block
    if block_given?
      content_tag :div, capture(&block), class: "container #{content_or_classes}"
    else
      content_tag :div, content_or_classes, class: "container #{classes}"
    end
  end
end
