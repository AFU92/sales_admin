defmodule SalesAdminWeb.SaleView do
  use SalesAdminWeb, :view
  alias SalesAdminWeb.{SaleView, SaleProductView}

  def render("index.json", %{sales: sales}) do
    render_many(sales, SaleView, "sale.json")
  end

  def render("show.json", %{sale: sale}) do
    render_one(sale, SaleView, "sale.json")
  end

  def render("sale.json", %{sale: sale}) do
    %{
      id: sale.id,
      customer_id: sale.customer_id,
      total_price: sale.total_price,
      payment_type_id: sale.payment_type_id,
      sale_products: render_many(sale.sale_products, SaleProductView, "sale_product.json")
    }
  end
end
