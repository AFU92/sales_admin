defmodule SalesAdminWeb.Router do
  use SalesAdminWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SalesAdminWeb do
    pipe_through :api
  end
end
