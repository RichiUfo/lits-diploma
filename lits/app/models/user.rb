class User < ApplicationRecord
  devise :trackable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

      if auth.info.email.blank?
      #  redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
      #TODO: remove this stub
        auth.info.email = "#{auth.uid}@mail.com"
      end

      user.email = auth.info.email
      user.name  = auth.info.name
    end
  end

  def avatar
    if provider == 'vkontakte'
      client = VkontakteApi::Client.new
      client.users.get(user_id: uid, fields: 'photo_50').first[:photo_50]
    elsif provider == 'facebook'
      avatar = Net::HTTP.get_response(URI("https://graph.facebook.com/#{uid}/picture"))
      avatar['location']
    else
      'https://99designs-blog.imgix.net/blog/wp-content/uploads/2013/03/odessa.png?auto=format&q=60&fit=min&w=100'
    end
  end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

end
