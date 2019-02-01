defmodule SalesAdmin.Inventories.PaymentType do
  use Ecto.Schema
  alias SalesAdmin.Inventories.Sale

  schema "payment_types" do
    field(:name, :string)
    field(:enabled, :boolean, default: true)

    has_many(:sales, Sale)

    timestamps(type: :utc_datetime)
  end
end
