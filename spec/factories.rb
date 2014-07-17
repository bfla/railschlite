FactoryGirl.define do

  factory :campsite do
    name        'Tranquil Dawn Campground'
    state       'MI'
    latitude    44.91319
    longitude   -86.0203
    elevation   30
    phone       7341231234
    total_sites 120
    electric_sites  100
    outhouse    true
    showers     true
    dump        true
  end

  factory :nearby_campsite, class: Campsite do
    name        'Nearby Sublime Campground'
    state       'MI'
    latitude    44.91318
    longitude   -86.0202
    elevation   29
    phone       7341235678
    total_sites 200
    electric_sites  200
    outhouse    false
    showers     false
    dump        false
  end

end