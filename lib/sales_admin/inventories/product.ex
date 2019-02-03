defmodule SalesAdmin.Inventories.Product do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, SaleProduct, Store, Product}

  import Ecto.Changeset

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

  @attrs [
    :name,
    :discription,
    :reference_store,
    :dimentions,
    :quantity,
    :image,
    :unit_price,
    :store_id
  ]
  @required_attrs [
    :name,
    :discription,
    :reference_store,
    :dimentions,
    :quantity,
    :image,
    :unit_price,
    :store_id
  ]

  def changeset(%Product{} = product, params \\ %{}) do
    product
    |> cast(params, @attrs)
    |> validate_required(@required_attrs)
  end
end
