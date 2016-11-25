FactoryGirl.define do
  factory :event do
    city_id 1
    source_id 1
    date Date.tomorrow
    name 'Cool event'
    description 'Cool event'
  end
end
