defmodule SalesAdminWeb.FallbackController do
  use SalesAdminWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(SalesAdminWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, msg}) do
    conn
    |> put_status(:not_found)
    |> render(SalesAdminWeb.ErrorView, "404.json", msg: msg)
  end
end
