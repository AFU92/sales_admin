defmodule SalesAdmin.Inventories do
  alias SalesAdmin.Inventories.{StoreType, Store, PaymentType, Customer, Product, Sale}
  alias SalesAdmin.Repo
  import Ecto.Query
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

  # --------------------------------PaymentTypes--------------------------------

  def list_payment_types do
    Repo.all(PaymentType)
  end

  def get_payment_type(id) do
    case Repo.get(PaymentType, id) do
      nil -> {:error, "Payment type not found for the given id: #{id}"}
      payment_type -> {:ok, payment_type}
    end
  end

  # --------------------------------Customer--------------------------------

  def list_customers do
    Repo.all(Customer)
  end

  def get_customer(id) do
    case Repo.get(Customer, id) do
      nil -> {:error, "Customer not found for the given id: #{id}"}
      customer -> {:ok, customer}
    end
  end

  def create_customer(params) do
    %Customer{}
    |> Customer.changeset(params)
    |> Repo.insert()
  end

  def update_customer(
        %Customer{} = customer,
        params
      ) do
    customer
    |> Customer.changeset(params)
    |> Repo.update()
  end

  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end

  # --------------------------------Product--------------------------------

  def list_products(store_id) do
    from(p in Product, where: p.store_id == ^store_id)
    |> Repo.all()
  end

  def get_product(store_id, id) do
    result =
      from(p in Product, where: p.store_id == ^store_id)
      |> Repo.get(id)

    case result do
      nil -> {:error, "Product not found for the given id: #{id}"}
      product -> {:ok, product}
    end
  end

  def list_products_by_name(store_id, product_name) do
    from(p in Product, where: p.store_id == ^store_id and like(p.name, ^product_name))
    |> Repo.all()
  end

  def create_product(params) do
    %Product{}
    |> Product.changeset(params)
    |> Repo.insert()
  end

  def update_product(
        %Product{} = product,
        params
      ) do
    product
    |> Product.changeset(params)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  # --------------------------------Sale--------------------------------

  def list_sales(store_id) do
    from(s in Sale, where: s.store_id == ^store_id)
    |> Repo.all()
  end

  def get_sale(store_id, id) do
    result =
      from(s in Sale, where: s.store_id == ^store_id)
      |> Repo.get(id)

    case result do
      nil -> {:error, "Sale not found for the given id: #{id}"}
      sale -> {:ok, sale}
    end
  end
end
