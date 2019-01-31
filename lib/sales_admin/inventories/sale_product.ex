defmodule SalesAdmin.Inventories.SaleProduct do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, Product}

  schema "sale_products" do
    field(:quantity, :float)
    field(:unit_price, :float)
    field(:total_prod_price, :float)

    belongs_to(:sale, Sale)
    belongs_to(:product, Product)

    timestamps(type: :utc_datetime)
  end
end
