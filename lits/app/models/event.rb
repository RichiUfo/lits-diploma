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
  scope :by_user, ->(user) { select('*')
                            .from("(#{user_tags_query(user)} UNION #{user_categories_query(user)}
                                    ) as events")}


  def self.user_tags_query(user)
    query = Event.select('events.*').joins(:tags).to_sql
    cond = if user.nil?
             ''
           else
             ids = user.tags.map(&:id).join(', ')
             ids = ids.empty? ? '-1' : ids
             "WHERE tags.id IN (#{ids})"
           end
    query + cond
  end
  def self.user_categories_query(user)
    query = Event.select('events.*').to_sql
    cond = if user.nil?
             ''
           else
             ids = user.categories.map(&:id).join(', ')
             ids = ids.empty? ? '-1' : ids
             "WHERE events.category_id IN (#{ids})"
           end
    query + cond
  end
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
    subquery = Category.select(:id).where('parent_id = ?', category_id.to_i).to_sql
    where("category_id = ? OR category_id IN (#{subquery})", category_id.to_i)
  end
end
