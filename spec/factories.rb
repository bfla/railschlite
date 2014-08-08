FactoryGirl.define do

  factory :campsite do
    name        'Tranquil Dawn Campground'
    state_abbrev 'PR'
    state
    latitude    44.91311
    longitude   -86.02031
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
    state_abbrev 'PR'
    state
    latitude    44.91311
    longitude   -86.02031
    elevation   29
    phone       7341235678
    total_sites 200
    electric_sites  200
    outhouse    false
    showers     false
    dump        false
  end

  factory :state do
    name            'Puerto Rico'
    abbrev    'PR'
    description     'Tropical paradis, ideal for camping!'
    hashtag         '51stCampers'
    zoom            10
    latitude        44.91311
    longitude       -86.02031
  end

  factory :destination do
    name        "Lilliput"
    state
    latitude    44.91311
    longitude   -86.02031
    zoom        6
    radius      30
    description "This place is neat but too small"
    highlights  "Huge Gulliver.  Small people."
    things_to_do "Tie down huge Gulliver"
    camping_tips "Watch out for the little people. They bite."
  end

end