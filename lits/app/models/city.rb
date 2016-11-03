class City < ApplicationRecord
  has_many :events

  def self.find_by_vk_id vk_id
    CitySourceType.find_by(source_type: SourceType::VK, ext_id: vk_id).city
  end
end
