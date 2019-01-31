defmodule SalesAdmin.Inventories.Store do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, Product, StoreType}

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
end
