defmodule WeatherWeb.API.NextThreeDaysForecastsController do
  use WeatherWeb, :controller
  alias Weather.API.NextThreeDaysForecastsData

  def index(conn, params) do
    data = NextThreeDaysForecastsData.get(params)
    render(conn, "index.json", data: data)
  end
end
