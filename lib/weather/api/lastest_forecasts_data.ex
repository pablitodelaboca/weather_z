defmodule Weather.API.LatestForecastsData do
  alias Weather.API.ForecastsData

  def get(params), do: ForecastsData.get(params, "latest_forecasts_url")
end
