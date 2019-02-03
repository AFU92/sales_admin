defmodule SalesAdmin.Inventories.Customer do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, Customer}
  alias SalesAdmin.Utils.GeoPointsConverter

  import Ecto.Changeset

  schema "customers" do
    field(:name, :string)
    field(:last_name, :string)
    field(:document_number, :string)
    field(:phones, {:array, :string})
    field(:address, :string)
    field(:location, Geo.Geometry)

    has_many(:sales, Sale)

    timestamps(type: :utc_datetime)
  end

  @attrs [:name, :last_name, :document_number, :phones, :address, :location]
  @required_attrs [:name, :last_name, :document_number, :phones, :address, :location]

  def changeset(
        %Customer{} = customer,
        %{"location" => %{"latitude" => _, "longitude" => _} = location} = params
      ) do
    result = GeoPointsConverter.converter_from_map_to_point(location)

    case result do
      {:ok, location_point} -> changeset(customer, Map.put(params, "location", location_point))
      {:error, msg} -> IO.puts("Error in customer changeset. #{msg}")
    end
  end

  def changeset(%Customer{} = customer, params \\ %{}) do
    customer
    |> cast(params, @attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:document_number, name: :customers_document_number_index)
  end
end
