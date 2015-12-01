defmodule Shopper.CustomerVisitController do
  use Shopper.Web, :controller

  alias Shopper.CustomerVisit

  def index(conn, params) do
    customer_visits = CustomerVisit.all(params)
    render(conn, "index.json", customer_visits: customer_visits)
  end

  # def show(conn, %{"id" => id}) do
  #   customer_visits = Repo.get!(CustomerVisit, id)
  #   render(conn, "show.json", customer_visits: customer_visits)
  # end
end
