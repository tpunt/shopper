defmodule Shopper.StoreVisit do
  use Shopper.Web, :model

  @distance_matrix_uri "https://maps.googleapis.com/maps/api/distancematrix/json"
  @api_key "AIzaSyDyILl9XSufn-8KHEvZ9StZuuRlwsTqmJw" # put in mix.exs?

  @derive {Phoenix.Param, key: :store_visit_id}

  @primary_key {:store_visit_id, :integer, []}
  schema "storevisits" do
    field :visit_date, Ecto.Date
    field :distance, :decimal, precision: 6, scale: 2
    field :distance_travelled, :decimal, precision: 6, scale: 2
    field :time_travelled, :integer
    belongs_to :customer, Shopper.Customer, [references: :customer_id]
    belongs_to :store, Shopper.Store, [references: :store_id]
  end

  @required_fields ~w(store_visit_id visit_date customer_id store_id)
  @optional_fields ~w(distance distance_travelled time_travelled)

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
    |> calculate_distance(params)
  end

  defp calculate_distance(changeset, _params) do
    [long1, lat1, postcode1] = Shopper.Repo.one(
      from c in Shopper.Customer,
        where: c.customer_id == ^changeset.changes.customer_id,
      select: [c.longitude, c.latitude, c.postcode]
    )

    [long2, lat2, postcode2] = Shopper.Repo.one(
      from s in Shopper.Store,
        where: s.store_id == ^changeset.changes.store_id,
      select: [s.longitude, s.latitude, s.postcode]
    )

    distance_miles = haversine_distance(long1, lat1, long2, lat2)

    changeset = put_change(changeset, :distance, Decimal.new(Float.round(distance_miles, 2)))

    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{distance: distance}} ->
        case fetch_distance_travelled(postcode1, postcode2) do
          {:ok, result} ->
            IO.puts "a"
            IO.inspect result
            changeset = put_change(changeset, :distance_travelled, Decimal.new(Float.round(result.miles, 2)))
            put_change(changeset, :time_travelled, round(result.minutes))
          _ ->
            IO.puts "b"
            # log here
            changeset
        end
      _ ->
        IO.puts "c"
        # log here
        changeset
    end
  end

  defp haversine_distance(long1, lat1, long2, lat2) do
    # The Haversine formula
    earth_radius = 6_371_000 # in metres
    dLat = (lat2 - lat1) * :math.pi / 180
    dLong = (long2 - long1) * :math.pi / 180
    a = :math.sin(dLat / 2) * :math.sin(dLat / 2) +
      :math.cos(lat1 * :math.pi / 180) * :math.cos(lat2 * :math.pi / 180) *
      :math.sin(dLong / 2) * :math.sin(dLong / 2)
    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
    distance = earth_radius * c

    distance * 0.000621371192 # convert
  end

  defp fetch_distance_travelled(postcode1, postcode2) do
    request = HTTPoison.get(
      "#{@distance_matrix_uri}?origins=#{postcode1}&destinations=#{postcode2}&key=#{@api_key}"
    )

    case request do
      {:ok, %HTTPoison.Response{body: body}} ->
        case Poison.Parser.parse!(body) do
          %{"rows" => [%{"elements" => [%{"distance" => %{"value" => metres}, "duration" => %{"value" => seconds}}]}]} ->
            {:ok, %{miles: metres * 0.000621371192, minutes: seconds / 60}}
          _ ->
            {:error, "No results"}
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
