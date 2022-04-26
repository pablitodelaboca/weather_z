defmodule WeatherWeb.API.LatestForecastsView do
  use WeatherWeb, :view

  def render("index.json", %{data: data}) do
    %{data: data}
  end
end
