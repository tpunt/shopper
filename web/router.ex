defmodule Shopper.Router do
  use Shopper.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/clientapi", Shopper do
    pipe_through :api

    resources "/customers", CustomerController, except: [:new, :edit]
    resources "/postcodes", PostcodeController, except: [:new, :edit]
    resources "/stores", StoreController, except: [:new, :edit]
    resources "/store_visits", StoreVisitController, except: [:new, :edit]

    get "/customer_visits", CustomerVisitController, :index
  end
end
