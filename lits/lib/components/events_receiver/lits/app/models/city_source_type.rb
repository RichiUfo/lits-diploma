class CitySourceType < ApplicationRecord
  belongs_to :city
  belongs_to :source_type
end
