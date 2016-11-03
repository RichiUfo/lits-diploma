SourceType.find_or_create_by id: 1, name: 'VK'
SourceType.find_or_create_by id: 2, name: 'FB'
SourceType.find_or_create_by id: 3, name: 'DOU'

SocialType.find_or_create_by id: 1, name: 'VK'
SocialType.find_or_create_by id: 2, name: 'FB'

City.find_or_create_by id: 1, name: 'Одесса'

CitySourceType.find_or_create_by id:1, city_id: 1, source_type_id: 1, ext_id: 292, ext_name: nil

Source.find_or_create_by id: 1, source_type_id: 1, ref: 'https://vk.com/hublivingroom', ext_id: 61599368
Source.find_or_create_by id: 2, source_type_id: 1, ref: 'https://vk.com/new.york.coffee', ext_id: 74120822
Source.find_or_create_by id: 3, source_type_id: 1, ref: 'https://vk.com/terminal_42', ext_id: 95160254
Source.find_or_create_by id: 4, source_type_id: 1, ref: 'https://vk.com/prostozapomni', ext_id: 23137059
Source.find_or_create_by id: 5, source_type_id: 1, ref: 'https://vk.com/greentheatreodessa', ext_id: 118880582
Source.find_or_create_by id: 6, source_type_id: 1, ref: 'https://vk.com/iqspace_odessa', ext_id: 20022966
