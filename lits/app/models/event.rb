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
  scope :by_tag, ->(tag) { joins(:tags).where(' LOWER(tags.name) = ? ', tag.name.downcase) }
  scope :future, -> { where('date > ?', Time.zone.now).order('date') }
  scope :by_user, lambda { |user|
    unless user.nil?
      select('DISTINCT events.*')
        .joins('LEFT JOIN event_tags et ON et.event_id = events.id')
        .joins('LEFT JOIN user_feed_tags uft ON uft.tag_id = et.tag_id')
        .joins('LEFT JOIN categories c ON events.category_id = c.id')
        .joins('LEFT JOIN user_feeds uf ON uf.category_id = c.id')
        .where('uft.user_id= ? OR uf.user_id= ?', user.id, user.id)
    end
  }

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

  def self.by_category(category_id)
    if category_id.to_i.zero?
      category = Category.find_by('LOWER(slug) = ?', category_id.downcase)
      category_id = category.present? ? category.id : -1
    end
    subquery = Category.select(:id).where('parent_id = ?', category_id.to_i).to_sql
    where("category_id = ? OR category_id IN (#{subquery})", category_id.to_i)
  end
end
