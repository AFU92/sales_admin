defmodule SalesAdminWeb.SaleProductView do
  use SalesAdminWeb, :view
  alias SalesAdminWeb.{ProductView}

  def render("sale_product.json", %{sale_product: sale_product}) do
    %{
      id: sale_product.id,
      quantity: sale_product.quantity,
      unit_price: sale_product.unit_price,
      total_prod_price: sale_product.total_prod_price,
      product: render_one(sale_product.product, ProductView, "product.json")
    }
  end
end
