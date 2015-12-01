defmodule Shopper.StoreVisitView do
  use Shopper.Web, :view

  def render("index.json", %{storevisits: storevisits}) do
    %{storeVisits: render_many(storevisits, Shopper.StoreVisitView, "store_visit.json")}
  end

  def render("show.json", %{store_visit: store_visit}) do
    %{storeVisit: render_one(store_visit, Shopper.StoreVisitView, "store_visit.json")}
  end

  def render("store_visit.json", %{store_visit: store_visit}) do
    %{store_visit_id: store_visit.store_visit_id,
      customer_id: store_visit.customer_id,
      store_id: store_visit.store_id,
      visit_date: store_visit.visit_date,
      distance_travelled: store_visit.distance_travelled}
  end
end
