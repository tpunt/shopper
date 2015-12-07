defmodule Shopper.CustomerView do
  use Shopper.Web, :view

  def render("index.json", %{customers: customers}) do
    %{customers: render_many(customers, Shopper.CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{customer: render_one(customer, Shopper.CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{customer_id: customer.customer_id, postcode: customer.postcode,
      longitude: customer.longitude, latitude: customer.latitude}
  end
end
