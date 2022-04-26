defmodule WeatherWeb.API.NextThreeDaysForecastsView do
  use WeatherWeb, :view

  def render("index.json", %{data: data}) do
    %{data: data}
  end
end
