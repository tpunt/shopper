defmodule Shopper.CustomerVisitView do
  use Shopper.Web, :view

  def render("index.json", %{customer_visits: customer_visits}) do
    %{customerVisits: render_many(customer_visits, Shopper.CustomerVisitView, "customer_visit.json")}
  end

  def render("customer_visit.json", %{customer_visit: customer_visit}) do
    %{customerLocation: %{
        postcode: customer_visit.postcode,
        longitude: customer_visit.longitude,
        latitude: customer_visit.latitude
      },
      storeId: customer_visit.store_id,
      distanceTravelled: customer_visit.distance_travelled,
      visitCount: customer_visit.visit_count
    }
  end
end
