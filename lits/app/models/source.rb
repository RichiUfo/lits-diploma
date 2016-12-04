class Source < ApplicationRecord
  belongs_to :source_type
  belongs_to :city

  validates :ref, presence: true, url: true, uniqueness: true
  validates :ext_id, numericality: true, uniqueness: true
end
