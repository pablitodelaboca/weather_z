defmodule Weather.API.CityCoordinatesData do
  alias Weather.API.Requests

  @api_key Application.get_env(:weather, :api_key)
  @base_api_geo_url Application.get_env(:weather, :base_api_geo_url)

  def get(city) do
    city
    |> build_url()
    |> Requests.get()
    |> parse_lat_and_lon()
  end

  defp build_url(city) do
    "#{@base_api_geo_url}/direct?q=#{city}&limit=1&appid=#{@api_key}"
  end

  defp parse_lat_and_lon(response) do
    {:ok, map_response} = Jason.decode(response)
    map_response_when_is_valid(map_response)
  end

  defp map_response_when_is_valid(map_response) do
    case map_response do
      # response was %{error: not found}
      %{} ->
        map_response

      _other ->
        [%{"lat" => lat, "lon" => lon}] = map_response
        {lat, lon}
    end
  end
end
