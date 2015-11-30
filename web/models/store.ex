defmodule Shopper.Store do
  use Shopper.Web, :model

  @derive {Phoenix.Param, key: :store_id}

  @primary_key {:store_id, :integer, []}
  schema "stores" do
    field :store_open_date, Ecto.Date
    field :post_code, :string
    field :longitude, :float
    field :latitude, :float
    has_many :storevisits, Shopper.StoreVisit #, foreign_key: store_visit_id
  end

  @required_fields ~w(store_id store_open_date post_code)
  @optional_fields ~w(longitude latitude)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> Shopper.PostCode.postcode_coords_changeset(params)
  end
end
