SourceType.find_or_create_by(id: 1).update_attributes name: 'vk', url: 'https://vk.com'
SourceType.find_or_create_by(id: 2).update_attributes name: 'fb', url: 'https://facebook.com'
SourceType.find_or_create_by(id: 3).update_attributes name: 'dou', url: 'https://dou.ua'

SocialType.find_or_create_by(id: 1).update_attributes name: 'vk'
SocialType.find_or_create_by(id: 2).update_attributes name: 'fb'

City.find_or_create_by(id: 1).update_attributes name: 'Одесса'

CitySourceType.find_or_create_by(id: 1).update_attributes city_id: 1, source_type_id: 1, ext_id: 292, ext_name: nil

Source.find_or_create_by(id: 1)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/hublivingroom', ext_id: 61599368, city_id: 1
Source.find_or_create_by(id: 2)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/new.york.coffee', ext_id: 74120822, city_id: 1
Source.find_or_create_by(id: 3)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/terminal_42', ext_id: 95160254, city_id: 1
Source.find_or_create_by(id: 4)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/prostozapomni', ext_id: 23137059, city_id: 1
Source.find_or_create_by(id: 5)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/greentheatreodessa', ext_id: 118880582, city_id: 1
Source.find_or_create_by(id: 6)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/iqspace_odessa', ext_id: 20022966, city_id: 1
Source.find_or_create_by(id: 7)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/standupod', ext_id: 61320421, city_id: 1
Source.find_or_create_by(id: 8)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/true_man_musicclub', ext_id: 24389413, city_id: 1
Source.find_or_create_by(id: 9)
      .update_attributes source_type_id: 1, ref: 'https://vk.com/wkaffff', ext_id: 1401801, city_id: 1
Source.find_or_create_by(id: 10)
      .update_attributes source_type_id: 3,
                         ref: 'https://dou.ua/calendar/feed/%D0%B2%D1%81%D0%B5%20%D1%82%D0%B5%D0%BC%D1%8B%2F%D0%9E%D0%B4%D0%B5%D1%81%D1%81%D0%B0',
                         ext_id: '',
                         city_id: 1

Source.find_or_create_by(id: 11)
    .update_attributes source_type_id: 2, ref: 'https://www.facebook.com/events/', ext_id: 113251612471720, city_id: 1
