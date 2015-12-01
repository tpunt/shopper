defmodule Shopper.StoreVisit do
  use Shopper.Web, :model

  @derive {Phoenix.Param, key: :store_visit_id}

  @primary_key {:store_visit_id, :integer, []}
  schema "storevisits" do
    field :visit_date, Ecto.Date
    field :distance_travelled, :decimal, precision: 6, scale: 2
    belongs_to :customer, Shopper.Customer, [references: :customer_id]
    belongs_to :store, Shopper.Store, [references: :store_id]
  end

  @required_fields ~w(store_visit_id visit_date customer_id store_id)
  @optional_fields ~w(distance_travelled)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def distance_travelled_changeset(model, params) do
    model
    |> changeset(params)
    |> calculate_distance_travelled(params)
  end

  defp calculate_distance_travelled(changeset, _params) do
    [long1, lat1] = Shopper.Repo.one(
      from c in Shopper.Customer,
        where: c.customer_id == ^changeset.changes.customer_id,
      select: [c.longitude, c.latitude]
    )

    [long2, lat2] = Shopper.Repo.one(
      from s in Shopper.Store,
        where: s.store_id == ^changeset.changes.store_id,
      select: [s.longitude, s.latitude]
    )

    # The Haversine formula
    r = 6_371_000
    dLat = (lat2 - lat1) * :math.pi / 180
    dLong = (long2 - long1) * :math.pi / 180
    a = :math.sin(dLat / 2) * :math.sin(dLat / 2) +
    :math.cos(lat1 * :math.pi / 180) * :math.cos(lat2 * :math.pi / 180) *
    :math.sin(dLong / 2) * :math.sin(dLong / 2)
    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
    distance_miles = r * c * 0.000621371192

    put_change(changeset, :distance_travelled, Decimal.new(Float.round(distance_miles, 2)))
  end
end
