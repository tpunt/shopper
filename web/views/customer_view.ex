defmodule Shopper.CustomerView do
  use Shopper.Web, :view

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, Shopper.CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, Shopper.CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id, post_code_id: customer.post_code_id}
  end
end
