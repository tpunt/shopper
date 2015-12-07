defmodule Shopper.PostcodeView do
  use Shopper.Web, :view

  def render("index.json", %{postcodes: postcodes}) do
    %{postcodes: render_many(postcodes, Shopper.PostcodeView, "postcode.json")}
  end

  def render("show.json", %{postcode: postcode}) do
    %{postcode: render_one(postcode, Shopper.PostcodeView, "postcode.json")}
  end

  def render("postcode.json", %{postcode: postcode}) do
    %{id: postcode.id,
      postcode: postcode.postcode,
      longitude: postcode.longitude,
      latitude: postcode.latitude}
  end
end
