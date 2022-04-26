# Weather

An application to collect weather data.

Currently the only API supported is https://openweathermap.org/api


## Configuration

* Get an API key an fill WEATHER_API_KEY VAR in the config.exs file.
The API key can be found, when you subscribe to open weather map API https://openweathermap.org/price


## Running

To start the application:
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000/api`](http://localhost:4000/api) from your browser.


## API

Bellow you can see our API to support weather data.

### Get the latest forecasts for a city or cities

In this endpoint we provide the latest forecasts for a city or cities.

Endpoint
* `/api/`

Params
* lat={lat}&lon={lon} - Include lat and long in the url
* city={city_name}    - Include the city name in the url

### WIP - Get the next 3 days forecasts for a city or cities

In this endpoint we provide the next 3 days forecasts for a city or cities, at the moment it is not available.

Endpoint
* `/api/next-3-days`

Params
*

### WIP - Get the warmest and coolest city in the next 3 days

In this endpoint we provide the warmest and coolest city in the next 3 days, at the moment it is not available.

Endpoint
* `/api/warmest-and-coolest`

Params
*


## Improvements

* Currently the APP_ID is left empty, this happens because, we do not want to be
with exceeded quotas, since this is a public repo this could happen.
In addition sensitivy data also might leak, and this is a security flaw.
The ideal scenario is to have this value on 1password or any other safe vault app,
for the team to use it.

* Since the weather API deprecates some features, the ideal thing for tests
is having a form for validating contracts, like VCR.
Using the API version, can also helps preventing deprecations issues.
Another option to validate contract, but not in a strict way
is to mock the function that, returns the json data.
This could be achieved with module mock or monkey patching.

* The collection of data happens on fly, but it would be nice to have
a GenServer or ETS collecting this data, so the response time would be better.

* At the moment users can filter cities by, city name or zip code.
It would be nice to have a pre-defined list, so the user does not have to
deal with error codes.

* Write module docs and function docs to make them even more clear.
