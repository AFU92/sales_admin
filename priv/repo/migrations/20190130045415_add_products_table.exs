defmodule SalesAdmin.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:name, :string, null: false)
      add(:discription, :string, null: false)
      add(:reference_store, :string)
      add(:dimentions, {:array, :float}, null: false)
      add(:cantidad, :float, null: false)
      add(:image, :string, null: false)
      add(:unit_price, :float, null: false)

      add(:store_id, references(:stores, on_delete: :restrict))

      timestamps(type: :timestamptz)
    end
  end
end
