defmodule SalesAdmin.Repo.Migrations.AddPaymentTypesTable do
  use Ecto.Migration

  def change do
    create table(:payment_types) do
      add(:name, :string, null: false)
      add(:enabled, :boolean, null: false)

      timestamps(type: :timestamptz)
    end

    create(unique_index(:payment_types, [:name]))
  end
end
