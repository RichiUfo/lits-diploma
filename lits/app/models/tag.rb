class Tag < ApplicationRecord
  extend FriendlyId
  has_many :event_tags
  has_many :events, through: :event_tags
  friendly_id :name, use: :slugged

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end

  def self.number
    select('tags.name, tags.slug, count(event_tags.tag_id) as count')
            .joins(:events)
            .group('tags.name, tags.slug, event_tags.tag_id')
            .where('date > ?', Time.zone.now)
  end
end
