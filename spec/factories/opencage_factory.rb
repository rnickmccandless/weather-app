# frozen_string_literal: true

FactoryBot.define do
  factory :opencage, class: Hash do
    documentation { 'https://opencagedata.com/api' }
    licenses do
      [{ 'name' => 'see attribution guide',
         'url' => 'https://opencagedata.com/credits' }]
    end
    rate { { 'limit' => 2500, 'remaining' => 2431, 'reset' => 1_690_848_000 } }
    results do
      [
        {
          'bounds' => { 'northeast' => { 'lat' => 37.7935167, 'lng' => -122.3957614 },
                        'southwest' => { 'lat' => 37.7934167,
                                         'lng' => -122.3958614 } },
          'components' => { 'ISO_3166-1_alpha-2' => 'US', 'ISO_3166-1_alpha-3' => 'USA',
                            'ISO_3166-2' => ['US-CA'], '_category' => 'building', '_type' => 'building',
                            'city' => 'San Francisco', 'continent' => 'North America', 'country' => 'United States',
                            'country_code' => 'us', 'house_number' => '140', 'neighbourhood' => 'Financial District',
                            'postcode' => '94105', 'road' => 'Market Street', 'state' => 'California',
                            'state_code' => 'CA' },
          'confidence' => 10, 'formatted' => '140 Market Street, San Francisco, CA 94105, United States of America',
          'geometry' => { 'lat' => 37.7934667, 'lng' => -122.3958114 }
        }, { 'bounds' => { 'northeast' => { 'lat' => 37.7548748, 'lng' => -122.4420527 },
                           'southwest' => { 'lat' => 37.7547748, 'lng' => -122.4421527 } },
             'components' => { 'ISO_3166-1_alpha-2' => 'US', 'ISO_3166-1_alpha-3' => 'USA', 'ISO_3166-2' => ['US-CA'],
                               '_category' => 'building', '_type' => 'building', 'city' => 'San Francisco',
                               'continent' => 'North America', 'country' => 'United States', 'country_code' => 'us',
                               'house_number' => '140', 'neighbourhood' => 'Noe Valley', 'postcode' => '94131',
                               'road' => 'Market Street', 'state' => 'California', 'state_code' => 'CA' },
             'confidence' => 10, 'formatted' => '140 Market Street, San Francisco, CA 94131, United States of America',
             'geometry' => { 'lat' => 37.7548248, 'lng' => -122.4421027 } },
        { 'components' => { 'ISO_3166-1_alpha-2' => 'US', 'ISO_3166-1_alpha-3' => 'USA', 'ISO_3166-2' => ['US-CA'],
                            '_category' => 'road', '_type' => 'road', 'continent' => 'North America',
                            'country' => 'United States of America', 'country_code' => 'us', 'road' => 'Market St',
                            'state' => 'California', 'state_code' => 'CA', 'town' => 'San Francisco' },
          'confidence' => 8, 'formatted' => 'Market St, San Francisco, CA, United States of America',
          'geometry' => { 'lat' => 37.793262, 'lng' => -122.395973 } },
        { 'bounds' => { 'northeast' => { 'lat' => 37.796628, 'lng' => -122.385181 },
                        'southwest' => { 'lat' => 37.784205, 'lng' => -122.403431 } },
          'components' => { 'ISO_3166-1_alpha-2' => 'US', 'ISO_3166-1_alpha-3' => 'USA', 'ISO_3166-2' => ['US-CA'],
                            '_category' => 'postcode', '_type' => 'postcode', 'continent' => 'North America',
                            'country' => 'United States of America', 'country_code' => 'us',
                            'county' => 'San Francisco County', 'postcode' => '94105', 'state' => 'California',
                            'state_code' => 'CA' }, 'confidence' => 7,
          'formatted' => 'San Francisco County, CA 94105, United States of America',
          'geometry' => { 'lat' => 37.7864, 'lng' => -122.3892 } }
      ]
    end
    status { { 'code' => 200, 'message' => 'OK' } }
    stay_informed do
      { 'blog' => 'https://blog.opencagedata.com',
        'mastodon' => 'https://en.osm.town/@opencage',
        'twitter' => 'https://twitter.com/OpenCage' }
    end
    thanks { 'For using an OpenCage API' }
    timestamp { { 'created_http' => 'Mon, 31 Jul 2023 03:33:49 GMT', 'created_unix' => 1_690_774_429 } }
    total_results { 4 }

    initialize_with { attributes }
  end
end
