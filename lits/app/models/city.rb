class City < ApplicationRecord
  has_many :events

  def self.find_by_vk_id vk_id
    city_source_type = CitySourceType.find_by(source_type: SourceType::KEYS[:vk], ext_id: vk_id)
    city_source_type.nil? ? nil : city_source_type.city  
  end
end
