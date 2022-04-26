defmodule WeatherWeb.Controllers.API.NextThreeDaysForecastsControllerTest do
  use WeatherWeb.ConnCase, async: false

  describe "GET /api/next-3-days/lat=lat&lon=lon" do
    test "shows a list of forecasts for a city", %{conn: conn} do
      conn =
        build_conn()
        |> get(
          Routes.next_three_days_forecasts_path(
            conn,
            :index,
            %{lat: 51.51, lon: 7.46}
          )
        )

      {:ok, response} = json_response(conn, 200)["data"] |> Jason.decode()

      assert %{
               "city" => %{
                 "name" => "Dortmund"
               },
               "list" => [_weather_a, _weather_b, _weather_c]
             } = response
    end

    test "shows an error for an invalid city", %{conn: conn} do
      conn =
        build_conn()
        |> get(Routes.latest_forecasts_path(conn, :index, %{lat: 5000, lon: 5000}))

      {:ok, response} = json_response(conn, 200)["data"] |> Jason.decode()

      assert %{"error" => "Not found"} = response
    end
  end

  describe "GET /api/next-3-days/city=city" do
    test "shows a list of forecasts for a city", %{conn: conn} do
      conn =
        build_conn()
        |> get(Routes.next_three_days_forecasts_path(conn, :index, %{city: "Dortmund"}))

      {:ok, response} = json_response(conn, 200)["data"] |> Jason.decode()

      assert %{
               "city" => %{
                 "name" => "Dortmund"
               },
               "list" => [_weather_a, _weather_b, _weather_c]
             } = response
    end

    test "shows an error for an invalid city", %{conn: conn} do
      conn =
        build_conn()
        |> get(Routes.next_three_days_forecasts_path(conn, :index, %{city: ""}))

      assert %{"error" => "Not found"} = json_response(conn, 200)["data"]
    end
  end

  describe "GET /api/next-3-days/warmest/city[]=city_a&city[]=city_b" do
    test "shows the warmest city", %{conn: conn} do
      conn =
        build_conn()
        |> get(
          Routes.next_three_days_forecasts_path(conn, :warmest, %{city: ["Dortmund", "Alaska"]})
        )

      assert %{"city" => "Dortmund"} = json_response(conn, 200)["data"]
    end

    test "shows an error for an invalid city", %{conn: conn} do
      conn =
        build_conn()
        |> get(Routes.next_three_days_forecasts_path(conn, :warmest, %{city: ["", ""]}))

      assert %{
               "city" => "",
               "temp" => %{"error" => "Not found"}
             } = json_response(conn, 200)["data"]
    end
  end

  describe "GET /api/next-3-days/coolest/city[]=city_a&city[]=city_b" do
    test "shows the coolest city", %{conn: conn} do
      conn =
        build_conn()
        |> get(
          Routes.next_three_days_forecasts_path(conn, :coolest, %{city: ["Dortmund", "Alaska"]})
        )

      assert %{"city" => "Alaska"} = json_response(conn, 200)["data"]
    end

    test "shows an error for an invalid city", %{conn: conn} do
      conn =
        build_conn()
        |> get(Routes.next_three_days_forecasts_path(conn, :coolest, %{city: ["", ""]}))

      assert %{
               "city" => "",
               "temp" => %{"error" => "Not found"}
             } = json_response(conn, 200)["data"]
    end
  end
end
