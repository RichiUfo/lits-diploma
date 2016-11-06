SourceType.find_or_create_by id: 1, name: 'vk'
SourceType.find_or_create_by id: 2, name: 'fb'
SourceType.find_or_create_by id: 3, name: 'dou'

SocialType.find_or_create_by id: 1, name: 'vk'
SocialType.find_or_create_by id: 2, name: 'fb'

City.find_or_create_by id: 1, name: 'Одесса'

CitySourceType.find_or_create_by id:1, city_id: 1, source_type_id: 1, ext_id: 292, ext_name: nil

Source.find_or_create_by id: 1, source_type_id: 1, ref: 'https://vk.com/hublivingroom', ext_id: 61599368, city_id: 1
Source.find_or_create_by id: 2, source_type_id: 1, ref: 'https://vk.com/new.york.coffee', ext_id: 74120822, city_id: 1
Source.find_or_create_by id: 3, source_type_id: 1, ref: 'https://vk.com/terminal_42', ext_id: 95160254, city_id: 1
Source.find_or_create_by id: 4, source_type_id: 1, ref: 'https://vk.com/prostozapomni', ext_id: 23137059, city_id: 1
Source.find_or_create_by id: 5, source_type_id: 1, ref: 'https://vk.com/greentheatreodessa', ext_id: 118880582, city_id: 1
Source.find_or_create_by id: 6, source_type_id: 1, ref: 'https://vk.com/iqspace_odessa', ext_id: 20022966, city_id: 1
Source.find_or_create_by id: 7, source_type_id: 1, ref: 'https://vk.com/standupod', ext_id: 61320421, city_id: 1
Source.find_or_create_by id: 8, source_type_id: 1, ref: 'https://vk.com/true_man_musicclub', ext_id: 24389413, city_id: 1
Source.find_or_create_by id: 9, source_type_id: 1, ref: 'https://vk.com/wkaffff', ext_id: 1401801, city_id: 1
