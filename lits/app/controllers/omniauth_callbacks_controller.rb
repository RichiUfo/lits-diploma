class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.available_providers
    # reject providers that were avaliable by default
    OmniAuth::Strategies.constants
                        .reject { |item| item =~ /Developer|OAuth2|Oauth/i }
                        .map(&:downcase)
  end

  available_providers.each do |provider|
    define_method(provider) do
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end
  end

  def failure
    redirect_to root_path
  end

  protected

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || session[:return_to]
  end
end
