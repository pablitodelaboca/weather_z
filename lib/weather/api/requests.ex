defmodule Weather.API.Requests do
  require Logger

  def get(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        Logger.error("Error #{status_code} for the following url: #{url}")
        not_found_response()

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Error #{inspect(reason)} for the following url: #{url}")
        not_found_response()
    end
  end

  defp not_found_response do
    {:ok, json} = Jason.encode(%{error: "Not found"})
    json
  end
end
