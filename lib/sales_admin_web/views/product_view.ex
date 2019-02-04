defmodule SalesAdminWeb.ProductView do
  use SalesAdminWeb, :view

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      discription: product.discription,
      reference_store: product.reference_store,
      dimentions: product.dimentions,
      quantity: product.quantity,
      image: product.image,
      unit_price: product.unit_price
    }
  end
end
