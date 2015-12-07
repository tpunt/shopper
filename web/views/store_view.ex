defmodule Shopper.StoreView do
  use Shopper.Web, :view

  def render("index.json", %{stores: stores}) do
    %{storeOpenings: render_many(stores, Shopper.StoreView, "store.json")}
  end

  def render("show.json", %{store: store}) do
    %{storeOpening: render_one(store, Shopper.StoreView, "store.json")}
  end

  def render("store.json", %{store: store}) do
    %{
      storeId: store.store_id,
      openDate: store.store_open_date,
      storeLocation: %{
        postcode: store.postcode,
        latitude: store.latitude,
        longitude: store.longitude
      }
    }
  end
end
