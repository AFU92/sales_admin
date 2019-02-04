defmodule SalesAdminWeb.SaleController do
  use SalesAdminWeb, :controller

  alias SalesAdmin.Inventories
  alias SalesAdmin.Inventories.Sale

  action_fallback(SalesAdminWeb.FallbackController)

  def index(conn, %{"store_id" => store_id}) do
    sales = Inventories.list_sales(store_id)
    render(conn, "index.json", sales: sales)
  end

  def show(conn, %{"store_id" => store_id, "id" => id}) do
    with {:ok, %Sale{} = sale} <- Inventories.get_sale(store_id, id) do
      render(conn, "show.json", sale: sale)
    end
  end

  def create(conn, %{
        "store_id" => store_id,
        "sale" => %{"sale_products" => _} = sale_params
      }) do
    sale_params = Map.put(sale_params, "store_id", store_id)

    with {:ok, %{sale: %Sale{} = sale}} <- Inventories.create_sale(sale_params) do
      {:ok, sale} = Inventories.get_sale(store_id, sale.id)

      conn
      |> put_status(:created)
      # |> put_req_header("location", store_sale_path(conn, :show, sale.store_id, sale))
      |> render("show.json", sale: sale)
    end
  end
end
