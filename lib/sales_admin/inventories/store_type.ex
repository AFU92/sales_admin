defmodule SalesAdmin.Inventories.StoreType do
  use Ecto.Schema
  alias SalesAdmin.Inventories.Store

  schema "store_types" do
    field(:name, :string)

    has_many(:stores, Store)

    timestamps(type: :utc_datetime)
  end
end
