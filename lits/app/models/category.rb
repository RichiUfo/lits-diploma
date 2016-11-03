class Category < ApplicationRecord
  has_many :events
  has_many :user_feeds
  has_many :users, through: :user_feeds
end
