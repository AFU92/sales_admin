defmodule SalesAdmin.Inventories.PaymentType do
  use Ecto.Schema
  alias SalesAdmin.Inventories.{Sale, PaymentType}

  import Ecto.Changeset

  schema "payment_types" do
    field(:name, :string)
    field(:enabled, :boolean, default: true)

    has_many(:sales, Sale)

    timestamps(type: :utc_datetime)
  end

  @attrs [:name]
  @required_attrs [:name]

  @spec changeset(
          %PaymentType{},
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%PaymentType{} = payment_type, params \\ %{}) do
    payment_type
    |> cast(params, @attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:email)
  end
end
