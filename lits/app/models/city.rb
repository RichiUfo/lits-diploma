class City < ApplicationRecord
  has_many :events
  has_many :sources

  def self.find_by_vk_id(vk_id)
    CitySourceType.find_by(source_type: SourceType::KEYS[:vk], ext_id: vk_id).try(:city)
  end
end
