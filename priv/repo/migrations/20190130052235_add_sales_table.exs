defmodule SalesAdmin.Repo.Migrations.AddSalesTable do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add(:total_price, :float, null: false)

      add(:store_id, references(:stores))
      add(:customer_id, references(:customers))
      add(:payment_type_id, references(:payment_types))

      timestamps(type: :timestamptz)
    end
  end
end
