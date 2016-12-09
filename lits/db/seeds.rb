SourceType.find_or_create_by(name: :vk).update_attributes url:  'https://vk.com'
SourceType.find_or_create_by(name: :fb).update_attributes url:  'https://facebook.com'
SourceType.find_or_create_by(name: :dou).update_attributes url: 'https://dou.ua'

vk_id  = SourceType.find_by(name: :vk).id
fb_id  = SourceType.find_by(name: :fb).id
dou_id = SourceType.find_by(name: :dou).id

odessa = City.find_or_create_by(name: 'Одесса')

CitySourceType.find_or_create_by(city_id: odessa.id, source_type_id: vk_id).update_attributes(ext_id: 292)
CitySourceType.find_or_create_by(city_id: odessa.id, source_type_id: fb_id).update_attributes(ext_id: 2384095, ext_name: 'Odessa')

Source.find_or_create_by(ext_id: 61599368)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/hublivingroom', city_id: odessa.id
Source.find_or_create_by(ext_id: 95160254)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/terminal_42', city_id: odessa.id
Source.find_or_create_by(ext_id: 23137059)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/prostozapomni', city_id: odessa.id
Source.find_or_create_by(ext_id: 118880582)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/greentheatreodessa', city_id: odessa.id
Source.find_or_create_by(ext_id: 20022966)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/iqspace_odessa', city_id: odessa.id
Source.find_or_create_by(ext_id: 61320421)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/standupod', city_id: odessa.id
Source.find_or_create_by(ext_id: 24389413)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/true_man_musicclub', city_id: odessa.id
Source.find_or_create_by(ext_id: 1401801)
      .update_attributes source_type_id: vk_id, ref: 'https://vk.com/wkaffff', city_id: odessa.id
Source.find_or_create_by(ref: 'https://dou.ua/calendar/feed/%D0%B2%D1%81%D0%B5%20%D1%82%D0%B5%D0%BC%D1%8B%2F%D0%9E%D0%B4%D0%B5%D1%81%D1%81%D0%B0')
      .update_attributes source_type_id: dou_id,
                         ext_id: '',
                         city_id: odessa.id
Source.find_or_create_by(ext_id: 981332051921505)
      .update_attributes source_type_id: fb_id, ref: 'https://facebook.com/MuseumForChange', city_id: odessa.id
Source.find_or_create_by(ext_id: 922406907773990)
      .update_attributes source_type_id: fb_id, ref: 'https://facebook.com/lavkaspeciy', city_id: odessa.id
Source.find_or_create_by(ext_id: 168373746580055)
      .update_attributes source_type_id: fb_id, ref: 'https://facebook.com/prosto.fm', city_id: odessa.id
Source.find_or_create_by(ext_id: 1661847287429096)
      .update_attributes source_type_id: fb_id, ref: 'https://facebook.com/arthouse.club', city_id: odessa.id
