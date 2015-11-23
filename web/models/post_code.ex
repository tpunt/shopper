defmodule Shopper.PostCode do
  use Shopper.Web, :model

  schema "postcodes" do
    field :post_code, :string, null: false
    field :longitude, :decimal
    field :latitude, :decimal
  end

  @required_fields ~w(post_code)
  @optional_fields ~w(longitude latitude)

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
