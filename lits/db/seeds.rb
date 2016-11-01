SourceType.find_or_create_by id: 1, name: 'VK'
SourceType.find_or_create_by id: 2, name: 'FB'
SourceType.find_or_create_by id: 3, name: 'DOU'

SocialType.find_or_create_by id: 1, name: 'VK'
SocialType.find_or_create_by id: 2, name: 'FB'

City.find_or_create_by id: 1, name: 'Одесса'

CitySourceType.find_or_create_by id:1, city_id: 1, source_type_id: 1, ext_id: 292, ext_name: nil

Source.find_or_create_by id: 1, source_type_id: 1, ref: 'https://vk.com/hublivingroom', ext_id: 61599368
