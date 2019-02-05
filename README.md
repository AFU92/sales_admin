# SalesAdmin

This repository has been created to solve Peiky's Backend Developer Test. The solution has been made with Elixir's Phoenix Framework (Official website: http://www.phoenixframework.org/).

## Prerequisites

In order to run this repo you must have installed the following software:

  * Docker: [https://docs.docker.com/install/](https://docs.docker.com/install/)
  * Erlang: [http://erlang.org/doc/installation_guide/INSTALL.html](http://erlang.org/doc/installation_guide/INSTALL.html)
  * Elixir: [https://elixir-lang.org/install.html](https://elixir-lang.org/install.html)
  * Postman: [https://www.getpostman.com/downloads/](https://www.getpostman.com/downloads/)

## Running the application 

  1. Clone this repository `https://github.com/AFU92/sales_admin.git`
  1. Run a docker container of a postgres with postgis image `docker run --name some-postgis -p 5432:5432 -d mdillon/postgis`
  1. Go to the cloned repository folder `cd sales_admin`
  1. Change the values of the SalesAdmin.Repo config in the file config/dev.exs according to the params sended in the postgres container creation
  1. Install dependencies with `mix deps.get`
  1. Create, migrate and run seeds to your database with `mix ecto.setup`
  1. Start Phoenix endpoint with `mix phx.server`
  
Now the app must be running. You can test the endpoints importing SalesAdmin.postman_collection.json in postman
