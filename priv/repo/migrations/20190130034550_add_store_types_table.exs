defmodule SalesAdmin.Repo.Migrations.AddStoreTypesTable do
  use Ecto.Migration

  def change do
    create table(:store_types) do
      add(:name, :string, null: false)

      timestamps(type: :timestamptz)
    end

    create(unique_index(:store_types, [:name]))
  end
end
