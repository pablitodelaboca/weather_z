defmodule WeatherWeb.API.LatestForecastsController do
  use WeatherWeb, :controller
  alias Weather.API.LatestForecastsData

  def index(conn, params) do
    data = LatestForecastsData.get(params)
    render(conn, "index.json", data: data)
  end
end
