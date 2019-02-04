defmodule SalesAdminWeb.StoreView do
  use SalesAdminWeb, :view
  alias SalesAdminWeb.{StoreView}

  def render("index.json", %{stores: stores}) do
    render_many(stores, StoreView, "store.json")
  end

  def render("show.json", %{store: store}) do
    render_one(store, StoreView, "store.json")
  end

  def render("store.json", %{store: store}) do
    %{
      id: store.id,
      name: store.name,
      nit: store.nit,
      phones: store.phones,
      location: store.location,
      address: store.address,
      extra_address: store.extra_address,
      store_type_id: store.store_type_id
    }
  end
end
