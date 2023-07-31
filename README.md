# Weather App

This weather application accepts an address and displays the current temperature, high & low temperatures, and 
a forecast of high & low temperatures for the next six days. Results are cached by zip code

There are two external endpoint requests required for this application to successfully retrieve weather information:

- Coordinates from a given address from [OpenCage](https://opencagedata.com/)
- The current and forecasted temperatures from the coordinates from [Open Meteo](https://open-meteo.com/)

## Dependencies

- API key from [OpenCage](https://opencagedata.com/) (free with account)
- Ruby 3.2

\*Note: Application is stateless, so no database is required to run the application.

## Setup

1. Clone application locally
2. Set environment variable `OPEN_CAGE_APP_KEY` to the key given from account [OpenCage](https://opencagedata.com/)
3. Run `bin/setup` to setup the application
4. Run `rspec` to ensure all tests pass
5. Run `rails s` to run the application locally

## Assumptions

- Uses latest stable Ruby & Rails versions
- Design with bootstrap 5
- All addresses are US based
- Uses default cache store - memory store
- Uses rubocop linting for majority of static code compliance
- Application won't be used in commercial applications, as per licensing agreements from API usages and assets
- No data storage requirements, so set application as stateless
