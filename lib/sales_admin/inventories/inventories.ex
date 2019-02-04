defmodule SalesAdmin.Inventories do
  alias SalesAdmin.Inventories.{StoreType, Store, PaymentType, Customer, Product, Sale}
  alias SalesAdmin.Repo
  alias Ecto.Multi
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
    |> Repo.preload(:sale_products)
    |> Repo.preload(sale_products: :product)
  end

  def get_sale(store_id, id) do
    result =
      from(s in Sale, where: s.store_id == ^store_id)
      |> Repo.get(id)
      |> Repo.preload(:sale_products)
      |> Repo.preload(sale_products: :product)

    case result do
      nil -> {:error, "Sale not found for the given id: #{id}"}
      sale -> {:ok, sale}
    end
  end

  def create_sale(sale) do
    Multi.new()
    |> Multi.insert(
      :sale,
      %Sale{}
      |> Sale.changeset(update_sale_to_creation(sale))
    )
    |> update_products_quantities(sale)
    |> Repo.transaction()
  end

  defp update_sale_to_creation(sale) do
    sale
    |> Map.put("sale_products", calculate_sale_product_prices(sale))
    |> Map.put("total_price", calculate_sale_total_price(sale))
  end

  defp calculate_sale_product_prices(%{"sale_products" => sale_products}) do
    Enum.map(sale_products, fn sale_product ->
      total_prod_price = Map.get(sale_product, "quantity") * Map.get(sale_product, "unit_price")
      Map.put(sale_product, "total_prod_price", total_prod_price)
    end)
  end

  defp calculate_sale_total_price(%{"sale_products" => sale_products}) do
    Enum.reduce(sale_products, 0, fn sale_product, acc ->
      Map.get(sale_product, "total_prod_price") + acc
    end)
  end

  defp update_products_quantities(multi, %{
         "sale_products" => sale_products,
         "store_id" => store_id
       }) do
    Enum.reduce(sale_products, multi, fn sale_product, acc ->
      product_id = Map.get(sale_product, "product_id")
      quantity = Map.get(sale_product, "quantity")

      {:ok, product} = get_product(store_id, product_id)

      product_update_changeset =
        Product.changeset(product, %{quantity: product.quantity - quantity})

      Multi.update(acc, String.to_atom("update_product_#{product_id}"), product_update_changeset)
    end)
  end
end
