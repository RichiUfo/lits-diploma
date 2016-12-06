class Source < ApplicationRecord
  belongs_to :source_type
  belongs_to :city
  has_many :events, dependent: :destroy
  validates :ref, presence: true, url: true, uniqueness: true
  validates :ext_id, numericality: true, uniqueness: true
end
