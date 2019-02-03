defmodule SalesAdmin.Inventories.StoreType do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Store, StoreType}

  import Ecto.Changeset

  schema "store_types" do
    field(:name, :string)

    has_many(:stores, Store)

    timestamps(type: :utc_datetime)
  end

  @attrs [:name]
  @required_attrs [:name]

  @spec changeset(
          %StoreType{},
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%StoreType{} = store_type, params \\ %{}) do
    store_type
    |> cast(params, @attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:email, name: :payment_types_name_index)
  end
end
