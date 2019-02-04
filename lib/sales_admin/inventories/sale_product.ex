defmodule SalesAdmin.Inventories.SaleProduct do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, Product, SaleProduct}

  import Ecto.Changeset

  schema "sale_products" do
    field(:quantity, :float)
    field(:unit_price, :float)
    field(:total_prod_price, :float)

    belongs_to(:sale, Sale)
    belongs_to(:product, Product)

    timestamps(type: :utc_datetime)
  end

  @attrs [:quantity, :unit_price, :total_prod_price, :sale_id, :product_id]
  @required_attrs [:quantity, :unit_price, :total_prod_price, :product_id]

  def changeset(%SaleProduct{} = sale_product, params \\ %{}) do
    sale_product
    |> cast(params, @attrs)
    |> validate_required(@required_attrs)
  end
end
