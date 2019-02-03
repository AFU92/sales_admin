defmodule SalesAdmin.Inventories.Sale do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Customer, Product, SaleProduct, Store, PaymentType, Sale}

  import Ecto.Changeset

  schema "sales" do
    field(:total_price, :float)

    belongs_to(:customer, Customer)
    belongs_to(:payment_type, PaymentType)
    belongs_to(:store, Store)
    has_many(:sale_products, SaleProduct)
    many_to_many(:products, Product, join_through: "sale_products")

    timestamps(type: :utc_datetime)
  end

  @attrs [:total_price, :customer_id, :payment_type_id, :store_id]
  @required_attrs [:total_price, :customer_id, :payment_type_id, :store_id]

  def changeset(%Sale{} = sale, params \\ %{}) do
    sale
    |> cast(params, @attrs)
    |> validate_required(@required_attrs)
  end
end
