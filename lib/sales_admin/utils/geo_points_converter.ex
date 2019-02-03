defmodule SalesAdmin.Utils.GeoPointsConverter do
  def converter_from_map_to_point(
        %{
          "latitude" => latitude,
          "longitude" => longitude
        } = _
      ) do
    {:ok, %Geo.Point{coordinates: {longitude, latitude}, srid: 4326}}
  end

  def converter_from_map_to_point(not_a_map) do
    {:error, "Unexpected param. Not a map #{not_a_map}"}
  end

  def converter_from_point_to_map(
        %Geo.Point{
          coordinates: {longitude, latitude},
          srid: 4326
        } = _
      ) do
    {
      :ok,
      %{
        "latitude" => latitude,
        "longitude" => longitude
      }
    }
  end

  def converter_from_point_to_map(not_a_point) do
    {:error, "Unexpected param. Not a Geo.Point #{not_a_point}"}
  end
end
