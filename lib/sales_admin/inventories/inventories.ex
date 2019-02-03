defmodule SalesAdmin.Inventories do
  alias SalesAdmin.Inventories.{StoreType, Store}
  alias SalesAdmin.Repo

  # --------------------------------StoresTypes--------------------------------

  def list_store_types do
    Repo.all(StoreType)
  end

  def get_store_type(id) do
    case Repo.get(StoreType, id) do
      nil -> {:error, "Store type not found for the given id: #{id}"}
      store_type -> {:ok, store_type}
    end
  end

  # -----------------------------------Stores-----------------------------------

  def list_stores do
    Repo.all(Store)
  end

  def get_store(id) do
    case Repo.get(Store, id) do
      nil -> {:error, "Store not found for the given id: #{id}"}
      store -> {:ok, store}
    end
  end

  def create_store(params) do
    %Store{}
    |> Store.changeset(params)
    |> Repo.insert()
  end

  def update_store(
        %Store{} = store,
        params
      ) do
    store
    |> Store.changeset(params)
    |> Repo.update()
  end

  def delete_store(%Store{} = store) do
    Repo.delete(store)
  end
end
