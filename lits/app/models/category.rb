class Category < ApplicationRecord
  extend FriendlyId
  has_many :events
  has_many :user_feeds
  has_many :users, through: :user_feeds
  friendly_id :name, use: :slugged

  validates :name, presence: true

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end
end
