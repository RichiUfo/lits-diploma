module NavbarHelper
  def navbar header, links, &block
    content_tag(:nav, class: 'navbar navbar-inverse navbar-fixed-top') do 
      header = navbar_header(header) 
      
      collapse = if block_given?
        navbar_collapse(links){ yield }
      else
        navbar_collapse(links)
      end

      container(header + collapse)
    end
  end

  private

  def navbar_header header
    content_tag :div, navbar_brand(header) + navbar_toggle, class: 'navbar-header'
  end

  def navbar_brand header
    link_to header, root_path, {class: 'navbar-brand'}
  end
  
  def navbar_toggle
    button_tag({class: 'navbar-toggle', 
                'aria-expanded' => false,
                'aria-controls' => 'navbar',
                data: {toggle: 'collapse', target: '#navbar-main' }}) do
        content_tag(:span, '', class: 'icon-bar') +
        content_tag(:span, '', class: 'icon-bar') +
        content_tag(:span, '', class: 'icon-bar') 
    end
  end

  def navbar_collapse links, &block
    content_tag :div, class: 'navbar-collapse collapse', id: 'navbar-main' do
      lis = links.keys.map do |key| 
        content_tag :li, link_to(key, links[key]), class: (current_page?(links[key])) ? 'active' : ''
      end

      content = content_tag(:ul, lis.join.html_safe, {class: 'nav navbar-nav'});

      if block_given?
        content = content + content_tag(:ul, capture(&block), {class: 'nav navbar-nav navbar-right'})      
      end

      content
    end
  end  
end
