module NavbarAuthHelper
  def navbar_auth
    user_signed_in? ? user_panel : auth_links
  end

  def auth_links
    concat link_to(content_tag(:i, '', class: 'fa fa-vk'), user_vkontakte_omniauth_authorize_path)
    concat link_to(content_tag(:i, '', class: 'fa fa-facebook-square'), user_facebook_omniauth_authorize_path)
  end

  def user_panel
    content_tag :li, user_avatar_button + user_panel_dropdown, class: 'dropdown user-panel'
  end

  def user_avatar_button
    content_tag :button, class: 'user-avatar-button', 'data-toggle' => 'dropdown' do
      image_tag current_user.avatar
    end
  end

  def user_avatar
  end

  def user_panel_dropdown
    content_tag :ul, class: 'dropdown-menu' do
      concat content_tag(:li, link_to('Настроить ленту', feed_edit_path))
      concat content_tag(:li, '', class: 'divider', role: 'separator')
      concat content_tag(:li, link_to('Выйти', destroy_user_session_path, method: 'delete'))
    end
  end
end
