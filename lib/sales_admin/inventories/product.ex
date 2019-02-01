defmodule SalesAdmin.Inventories.Product do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, SaleProduct, Store}

  schema "products" do
    field(:name, :string)
    field(:discription, :string)
    field(:reference_store, :string)
    field(:dimentions, {:array, :float})
    field(:quantity, :float)
    field(:image, :string)
    field(:unit_price, :float)

    belongs_to(:store, Store)
    has_many(:sale_products, SaleProduct)
    many_to_many(:sales, Sale, join_through: "sale_products")

    timestamps(type: :utc_datetime)
  end
end
