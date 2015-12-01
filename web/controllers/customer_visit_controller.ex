defmodule Shopper.CustomerVisitController do
  use Shopper.Web, :controller

  alias Shopper.CustomerVisit

  def index(conn, params) do
    customer_visits = CustomerVisit.all(params)
    render(conn, "index.json", customer_visits: customer_visits)
  end
end
