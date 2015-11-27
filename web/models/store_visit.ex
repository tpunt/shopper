defmodule Shopper.StoreVisit do
  use Shopper.Web, :model

  schema "storevisits" do
    field :visit_date, Ecto.Date
    field :distance_travelled, :decimal
    belongs_to :customer, Shopper.Customer
    belongs_to :store, Shopper.Store
  end

  @required_fields ~w(visit_date distance_travelled customer_id store_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
