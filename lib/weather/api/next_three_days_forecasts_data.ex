defmodule Weather.API.NextThreeDaysForecastsData do
  alias Weather.API.ForecastsData

  def get(params), do: ForecastsData.get(params, "next_three_days_forecasts_url")

  def warmest(params) do
    params
    |> calculate_max_or_min_temp_for_cities("temp_max")
    |> Enum.max_by(& &1.temp)
  end

  def coolest(params) do
    params
    |> calculate_max_or_min_temp_for_cities("temp_min")
    |> Enum.min_by(& &1.temp)
  end

  defp calculate_max_or_min_temp_for_cities(params, max_or_min_temp) do
    Enum.map(params["city"], fn city ->
      temp =
        %{"city" => city}
        |> ForecastsData.get("next_three_days_forecasts_url")
        |> get_city_max_or_min_temps(max_or_min_temp)

      %{city: city, temp: temp}
    end)
  end

  defp get_city_max_or_min_temps(forecast, max_or_min_temp) do
    case forecast do
      # forecast was %{error: not found}
      %{} ->
        forecast

      _other ->
        get_correct_temp(forecast, max_or_min_temp)
    end
  end

  defp get_correct_temp(forecast, max_or_min_temp) do
    {:ok, mapped_forecast} = Jason.decode(forecast)

    temp =
      mapped_forecast["list"]
      |> Enum.map(fn single_forecast ->
        single_forecast["main"][max_or_min_temp]
      end)
      |> get_max_or_min_temp_for_forecast(max_or_min_temp)
  end

  defp get_max_or_min_temp_for_forecast(temp, "temp_max") do
    Enum.max(temp)
  end

  defp get_max_or_min_temp_for_forecast(temp, "temp_min") do
    Enum.min(temp)
  end
end
