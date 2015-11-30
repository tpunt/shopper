defmodule Shopper.CustomerView do
  use Shopper.Web, :view

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, Shopper.CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, Shopper.CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{customer_id: customer.customer_id, post_code: customer.post_code,
      longitude: customer.longitude, latitude: customer.latitude}
  end
end
