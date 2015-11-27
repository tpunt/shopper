defmodule Shopper.Store do
  use Shopper.Web, :model

  schema "stores" do
    field :store_open_date, Ecto.Date
    belongs_to :post_code, Shopper.PostCode
  end

  @required_fields ~w(store_open_date post_code_id)
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
