class EventTag < ApplicationRecord
  belongs_to :event
  belongs_to :tag

  scope :by_event, ->(event) { where('event_id' => event.id) }
end
