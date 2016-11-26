class Tag < ApplicationRecord
  extend FriendlyId
  has_many :event_tags
  has_many :events, through: :event_tags
  friendly_id :name, use: :slugged
end
