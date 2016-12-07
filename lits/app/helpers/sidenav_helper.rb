module SidenavHelper
  def pusher
    content_tag(:div, class: :pusher) { yield }
  end

  def sidenav
    content_tag(:nav, class: 'ui sidebar vertical menu') do
      content_tag :ul do
        safe_join(sidenav_categories.map do |category|
          content_tag :li do
            safe_join([link_to(category[1][:name], category_path(category[0])),
                       children_list(category[1][:children])])
          end
        end)
      end
    end
  end

  def children_list(children)
    return '' if children.nil?
    content_tag :ul, class: 'children-list' do
      children.to_json
      safe_join(children.map do |category|
        content_tag :li, class: 'children-link' do
          link_to category[:name], category_path(category[:id])
        end
      end)
    end
  end

  def sidenav_categories
    create_tree Category.order('parent_id DESC').all
  end

  def create_tree(categories)
    categories_tree = {}

    categories.each do |category|
      if category.parent_id.blank?
        categories_tree[category.id] = symbol_attributes(category).merge(children: [])
      elsif categories_tree[category.parent_id].present?
        categories_tree[category.parent_id][:children] << symbol_attributes(category)
      end
    end

    categories_tree
  end

  def symbol_attributes(category)
    category.attributes.symbolize_keys
  end
end
