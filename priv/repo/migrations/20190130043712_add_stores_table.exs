defmodule SalesAdmin.Repo.Migrations.AddStoresTable do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add(:name, :string, null: false)
      add(:nit, :string)
      add(:phones, {:array, :string}, null: false)
      add(:location, :geometry, null: false)
      add(:address, :string, null: false)
      add(:extra_address, :string)

      add(:store_type_id, references(:store_types))

      timestamps(type: :timestamptz)
    end

    create(unique_index(:stores, [:name]))
  end
end
