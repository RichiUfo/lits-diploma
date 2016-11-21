class Event < ApplicationRecord
  belongs_to :city
  belongs_to :organizer, optional: true
  belongs_to :category, optional: true
  belongs_to :source, optional: true
  belongs_to :format, optional: true
  has_many :event_tags
  has_many :tags, through: :event_tags

  scope :vk_source, -> { joins(:source).where('sources.source_type_id' => SourceType::KEYS[:vk]) }
  scope :fb_source, -> { joins(:source).where('sources.source_type_id' => SourceType::KEYS[:fb]) }
  scope :dou_source, -> { joins(:source).where('sources.source_type_id' => SourceType::KEYS[:dou]) }
  scope :by_day, ->(date) { where('date::date = ?', date.to_date) }
  scope :by_today, -> { by_day(Time.zone.today) }
end
