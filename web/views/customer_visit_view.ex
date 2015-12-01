defmodule Shopper.CustomerVisitView do
  use Shopper.Web, :view

  def render("index.json", %{customer_visits: customer_visits}) do
    %{customerVisits: render_many(customer_visits, Shopper.CustomerVisitView, "customer_visit.json")}
  end

  # def render("show.json", %{customer_visit: customer_visit}) do
  #   %{customVisit: render_one(customer_visit, Shopper.CustomerVisitView, "customer_visit.json")}
  # end

  def render("customer_visit.json", %{customer_visit: customer_visit}) do
    %{customerLocation: %{
        postCode: customer_visit.post_code,
        longitude: customer_visit.longitude,
        latitude: customer_visit.latitude
      },
      storeId: customer_visit.store_id,
      distance_travelled: customer_visit.distance_travelled
    }
  end
end
