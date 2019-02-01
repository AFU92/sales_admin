# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SalesAdmin.Repo.insert!(%SalesAdmin.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SalesAdmin.Repo
alias SalesAdmin.Inventories.{Customer, Product, Store, StoreType, PaymentType}

Repo.insert!(%PaymentType{
  name: "Credit_card"
})

Repo.insert!(%PaymentType{
  name: "Debit_card"
})

Repo.insert!(%PaymentType{
  name: "Cash"
})

%{id: shoes_store_id} =
  Repo.insert!(%StoreType{
    name: "Shoes"
  })

Repo.insert!(%StoreType{
  name: "Groceries"
})

Repo.insert!(%StoreType{
  name: "Clothes"
})

Repo.insert!(%Store{
  name: "Pacman's shoes",
  nit: "1-123456",
  phones: ["316255"],
  location: %Geo.Point{coordinates: {-74.058221, 4.693493}, srid: 4326},
  address: "Calle 105 # 46",
  extra_address: "La casa azul con vitrinas grandes",
  store_type_id: shoes_store_id
})

Repo.insert!(%Customer{
  name: "Pepito",
  last_name: "Perez",
  document_number: "1090222333",
  phones: ["8112233"],
  address: "Calle 145",
  location: %Geo.Point{coordinates: {-74.050938, 4.727402}, srid: 4326}
})

Repo.insert!(%Product{
  name: "Girl Tennis",
  discription: "White",
  reference_store: "GTW001",
  dimentions: [1.0, 1.0, 1.0],
  quantity: 2.0,
  image: "",
  unit_price: 100.0
})
