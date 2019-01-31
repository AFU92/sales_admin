defmodule SalesAdmin.Inventories.Sale do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Customer, Product, SaleProduct, Store, PaymentType}

  schema "sales" do
    field(:total_price, :float)

    belongs_to(:customer, Customer)
    belongs_to(:payment_type, PaymentType)
    belongs_to(:store, Store)
    has_many(:sale_products, SaleProduct)
    many_to_many(:products, Product, join_through: "sale_products")

    timestamps(type: :utc_datetime)
  end
end
