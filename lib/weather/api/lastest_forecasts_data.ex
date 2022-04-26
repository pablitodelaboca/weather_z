defmodule Weather.API.LatestForecastsData do
  alias Weather.API.{
    CityCoordinatesData,
    Requests
  }

  @api_key Application.get_env(:weather, :api_key)
  @base_api_data_url Application.get_env(:weather, :base_api_data_url)

  def get(%{"lat" => lat, "lon" => lon}) do
    build_url({lat, lon})
    |> Requests.get()
  end

  def get(%{"city" => city}) do
    city
    |> CityCoordinatesData.get()
    |> get_city_when_coordinates_is_valid()
  end

  defp get_city_when_coordinates_is_valid(city_coordinates) do
    case city_coordinates do
      # cooordinates were %{error: not found}
      %{} ->
        city_coordinates

      _other ->
        city_coordinates
        |> build_url()
        |> Requests.get()
    end
  end

  defp build_url({lat, lon}) do
    "#{@base_api_data_url}/weather?lat=#{lat}&lon=#{lon}&appid=#{@api_key}"
  end
end
