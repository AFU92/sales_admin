defmodule SalesAdmin.Inventories.Store do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, Product, StoreType, Store}
  alias SalesAdmin.Utils.GeoPointsConverter

  import Ecto.Changeset

  schema "stores" do
    field(:name, :string)
    field(:nit, :string)
    field(:phones, {:array, :string})
    field(:location, Geo.Geometry)
    field(:address, :string)
    field(:extra_address, :string)

    has_many(:sales, Sale)
    has_many(:products, Product)
    belongs_to(:store_type, StoreType)

    timestamps(type: :utc_datetime)
  end

  @attrs [:name, :nit, :phones, :location, :address, :extra_address, :store_type_id]
  @required_attrs [:name, :nit, :phones, :location, :address, :extra_address, :store_type_id]

  def changeset(
        %Store{} = store,
        %{"location" => %{"latitude" => _, "longitude" => _} = location} = params
      ) do
    result = GeoPointsConverter.converter_from_map_to_point(location)

    case result do
      {:ok, location_point} -> changeset(store, Map.put(params, "location", location_point))
      {:error, msg} -> IO.puts("Error in store changeset. #{msg}")
    end
  end

  def changeset(%Store{} = store, params \\ %{}) do
    store
    |> cast(params, @attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:name, name: :store_name_index)
  end
end
