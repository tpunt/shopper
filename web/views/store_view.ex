defmodule Shopper.StoreView do
  use Shopper.Web, :view

  def render("index.json", %{stores: stores}) do
    %{data: render_many(stores, Shopper.StoreView, "store.json")}
  end

  def render("show.json", %{store: store}) do
    %{data: render_one(store, Shopper.StoreView, "store.json")}
  end

  def render("store.json", %{store: store}) do
    %{id: store.id,
      store_post_code_id: store.store_post_code_id,
      store_open_date: store.store_open_date}
  end
end
