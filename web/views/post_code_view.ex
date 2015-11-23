defmodule Shopper.PostCodeView do
  use Shopper.Web, :view

  def render("index.json", %{postcodes: postcodes}) do
    %{data: render_many(postcodes, Shopper.PostCodeView, "post_code.json")}
  end

  def render("show.json", %{post_code: post_code}) do
    %{data: render_one(post_code, Shopper.PostCodeView, "post_code.json")}
  end

  def render("post_code.json", %{post_code: post_code}) do
    %{id: post_code.id,
      post_code: post_code.post_code,
      longitude: post_code.longitude,
      latitude: post_code.latitude}
  end
end
