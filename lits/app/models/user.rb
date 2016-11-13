class User < ApplicationRecord
  devise :trackable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name  = auth.info.name
    end
  end

  def avatar
    if provider == 'vkontakte'
      client = VkontakteApi::Client.new
      client.users.get(user_id: uid, fields: 'photo_50').first[:photo_50]
    elsif provider == 'facebook'
      "http://graph.facebook.com/#{uid}/picture?type=square"
    else
      ''
    end
  end
end
