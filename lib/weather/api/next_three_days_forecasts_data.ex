defmodule Weather.API.NextThreeDaysForecastsData do
  alias Weather.API.ForecastsData

  def get(params), do: ForecastsData.get(params, "next_three_days_forecasts_url")
end
