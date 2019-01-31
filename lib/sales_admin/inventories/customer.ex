defmodule SalesAdmin.Inventories.Customer do
  use Ecto.Schema
  alias SalesAdmin.Inventories.Sale

  schema "customers" do
    field(:name, :string)
    field(:last_name, :string)
    field(:document_number, :string)
    field(:phone, {:array, :string})
    field(:address, :string)
    field(:location, Geo.Geometry)

    has_many(:sales, Sale)

    timestamps(type: :utc_datetime)
  end
end
