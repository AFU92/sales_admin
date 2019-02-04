defmodule SalesAdminWeb.StoreController do
  use SalesAdminWeb, :controller
  alias SalesAdmin.Inventories.Store

  alias SalesAdmin.Inventories

  action_fallback(SalesAdminWeb.FallbackController)

  def index(conn, _params) do
    stores = Inventories.list_stores()
    render(conn, "index.json", stores: stores)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Store{} = store} <- Inventories.get_store(id) do
      store = Inventories.convert_location(store)
      render(conn, "show.json", store: store)
    end
  end

  def create(conn, params) do
    with {:ok, %Store{} = store} <- Inventories.create_store(params) do
      store = Inventories.convert_location(store)

      conn
      |> put_status(:created)
      |> render("show.json", store: store)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %Store{} = store} <- Inventories.get_store(id) do
      with {:ok, %Store{} = store} <- Inventories.update_store(store, params) do
        store = Inventories.convert_location(store)

        conn
        |> render("show.json", store: store)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Store{} = store} <- Inventories.get_store(id) do
      with {:ok, %Store{} = store} <- Inventories.delete_store(store) do
        store = Inventories.convert_location(store)

        conn
        |> render("show.json", store: store)
      end
    end
  end
end
