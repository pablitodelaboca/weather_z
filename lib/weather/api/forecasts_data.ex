defmodule Weather.API.ForecastsData do
  alias Weather.API.{
    CityCoordinatesData,
    Requests
  }

  @api_key Application.get_env(:weather, :api_key)
  @base_api_data_url Application.get_env(:weather, :base_api_data_url)

  def get(%{"lat" => lat, "lon" => lon}, url) do
    build_url({lat, lon}, url)
    |> Requests.get()
  end

  def get(%{"city" => city}, url) do
    city
    |> CityCoordinatesData.get()
    |> get_city_when_coordinates_is_valid(url)
  end

  defp get_city_when_coordinates_is_valid(city_coordinates, url) do
    case city_coordinates do
      # cooordinates were %{error: not found}
      %{} ->
        city_coordinates

      _other ->
        city_coordinates
        |> build_url(url)
        |> Requests.get()
    end
  end

  defp build_url({lat, lon}, "latest_forecasts_url") do
    "#{@base_api_data_url}/weather?lat=#{lat}&lon=#{lon}&appid=#{@api_key}"
  end

  defp build_url({lat, lon}, "next_three_days_forecasts_url") do
    "#{@base_api_data_url}/forecast?lat=#{lat}&lon=#{lon}&cnt=3&appid=#{@api_key}"
  end
end
