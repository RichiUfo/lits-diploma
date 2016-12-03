class Source < ApplicationRecord
  belongs_to :source_type
  belongs_to :city

  validates :ref, presence: true, url: true
#  validates :ext_id, presence: false, numericality: true
end
