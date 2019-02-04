defmodule SalesAdmin.Repo.Migrations.AddSaleProductsTable do
  use Ecto.Migration

  def change do
    create table(:sale_products) do
      add(:quantity, :float, null: false)
      add(:unit_price, :float, null: false)
      add(:total_prod_price, :float, null: false)

      add(:product_id, references(:products))
      add(:sale_id, references(:sales))

      timestamps(type: :timestamptz)
    end
  end
end
