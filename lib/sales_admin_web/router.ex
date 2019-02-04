defmodule SalesAdminWeb.Router do
  use SalesAdminWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", SalesAdminWeb do
    pipe_through(:api)

    resources("/stores", StoreController, except: [:new, :edit]) do
      resources("/sales", SaleController, only: [:index, :show, :create])
    end
  end
end
