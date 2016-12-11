module NavbarHelper
  def navbar
    content_tag(:nav, container { yield }, class: 'navbar navbar-inverse navbar-fixed-top')
  end

  def sidebar_toggle
    button_tag fa(:bars), class: 'sidebar-toggle'
  end

  def app_header
    link_to image_tag('/white-logo.png'), '/', class: 'navbar-brand'
  end

  def city_select
    select_tag :city,
               options_from_collection_for_select(City.all, 'id', 'name'),
               class: 'city-select'
  end

  def search_form
    form_tag '/search', method: :get, class: 'search-form' do
      search_field_tag(:q, params[:q]) + search_button
    end
  end

  def auth_panel
    user_signed_in? ? user_panel : log_in_with
  end

  def log_in_with
    content_tag :div, log_in_toggle + log_in_list, class: 'log-in-with pull-right'
  end

  def log_in_toggle
    button_tag('Вход', id: 'log-in-with-toggle',
                       class: 'log-in-with-toggle',
                       data: { toggle: 'dropdown' })
  end

  def log_in_list
    content_tag(:ul, aria: { labelledby: 'log-in-with-toggle' }, class: 'dropdown-menu') do
      content_tag(:li, link_to(fa(:vk), user_vkontakte_omniauth_authorize_path, class: :vk)) +
        content_tag(:li, link_to(fa(:facebook),
                                 user_facebook_omniauth_authorize_path,
                                 class: :facebook))
    end
  end

  def user_panel
    content_tag :div,
                user_avatar_button + user_panel_dropdown,
                class: 'dropdown user-panel pull-right'
  end

  def user_avatar_button
    content_tag :button, class: 'user-avatar-button', 'data-toggle' => 'dropdown' do
      image_tag current_user.avatar
    end
  end

  def user_panel_dropdown
    content_tag :ul, class: 'dropdown-menu' do
      concat content_tag(:li, link_to('Настроить ленту', user_edit_path))
      concat content_tag(:li, '', class: 'divider', role: 'separator')
      concat content_tag(:li, link_to('Выйти', destroy_user_session_path, method: 'delete'))
    end
  end

  def search_button
    button_tag fa(:search), type: :submit
  end
end
