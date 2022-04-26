defmodule WeatherWeb.API.NextThreeDaysForecastsController do
  use WeatherWeb, :controller
  alias Weather.API.NextThreeDaysForecastsData

  def index(conn, params) do
    data = NextThreeDaysForecastsData.get(params)
    render(conn, "index.json", data: data)
  end

  def warmest(conn, params) do
    data = NextThreeDaysForecastsData.warmest(params)
    render(conn, "warmest.json", data: data)
  end

  def coolest(conn, params) do
    data = NextThreeDaysForecastsData.coolest(params)
    render(conn, "coolest.json", data: data)
  end
end
