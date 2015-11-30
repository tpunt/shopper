defmodule Shopper.StoreView do
  use Shopper.Web, :view

  def render("index.json", %{stores: stores}) do
    %{data: render_many(stores, Shopper.StoreView, "store.json")}
  end

  def render("show.json", %{store: store}) do
    %{data: render_one(store, Shopper.StoreView, "store.json")}
  end

  def render("store.json", %{store: store}) do
    %{store_id: store.store_id,
      store_post_code: store.post_code,
      longitude: store.longitude,
      latitude: store.latitude,
      store_open_date: store.store_open_date}
  end
end
