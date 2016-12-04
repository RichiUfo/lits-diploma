class Event < ApplicationRecord
  extend FriendlyId
  belongs_to :city
  belongs_to :organizer, optional: true
  belongs_to :category, optional: true
  belongs_to :source, optional: true
  belongs_to :format, optional: true
  has_many :event_tags
  has_many :tags, through: :event_tags
  friendly_id :name_and_sequence, use: :slugged
  paginates_per PER_PAGE_DEFAULT

  scope :vk_source, -> { joins(:source).where('sources.source_type_id' => SourceType::KEYS[:vk]) }
  scope :fb_source, -> { joins(:source).where('sources.source_type_id' => SourceType::KEYS[:fb]) }
  scope :dou_source, -> { joins(:source).where('sources.source_type_id' => SourceType::KEYS[:dou]) }
  scope :by_day, ->(date) { where('date::date = ?', date.to_date) }
  scope :by_today, -> { by_day(Time.zone.today) }
  scope :by_tag, ->(tag) { joins(:tags).where(tags: { name: tag.name }) }
  scope :future, -> { where('date > ?', Time.zone.now).order('date') }

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end

  def name_and_sequence
    slug = name.to_param
    sequence = ext_id
    "#{slug}--#{sequence}"
  end

  def self.search(query)
    Event.where('LOWER(name) LIKE ?', "%#{query.downcase}%").all
  end
end
