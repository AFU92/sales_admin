defmodule SalesAdmin.Repo.Migrations.AddCustomersTable do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add(:name, :string, null: false)
      add(:last_name, :string, null: false)
      add(:document_number, :string, null: false)
      add(:phone, {:array, :string}, null: false)
      add(:address, :string, null: false)
      add(:location, :geometry, null: false)

      timestamps(type: :timestamptz)
    end

    create(unique_index(:customers, [:document_number]))
  end
end
