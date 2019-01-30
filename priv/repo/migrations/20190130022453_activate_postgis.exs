defmodule SalesAdmin.Repo.Migrations.ActivatePostgis do
  use Ecto.Migration
  alias Ecto.Adapters.SQL
  alias SalesAdmin.Repo

  def change do
    SQL.query(
      Repo,
      "CREATE EXTENSION IF NOT EXISTS postgis"
    )
  end
end
