class Event < ApplicationRecord
  belongs_to :city
  belongs_to :organizer
  belongs_to :category
  belongs_to :source
  belongs_to :format
  has_many :event_tags
  has_many :tags, through: :event_tags
end
