class Tag < ApplicationRecord
  extend FriendlyId
  has_many :event_tags
  has_many :events, through: :event_tags
  friendly_id :name, use: :slugged
  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end
end
