defmodule Shopper.PostCode do
  use Shopper.Web, :model

  schema "postcodes" do
    field :post_code, :string, null: false
    field :longitude, :decimal
    field :latitude, :decimal
  end

  @required_fields ~w(post_code)
  @optional_fields ~w(longitude latitude)

  @api_uri "https://maps.googleapis.com/maps/api/geocode/json"
  @api_key "AIzaSyDyILl9XSufn-8KHEvZ9StZuuRlwsTqmJw"

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:post_code, min: 6, max: 8)
  end

  def postcode_coords_changeset(model, params) do
    model
    |> changeset(params)
    |> get_postcode_coords()
  end

  defp get_postcode_coords(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{post_code: post_code}} ->
        case fetch_coords(post_code) do
          {:ok, result} ->
            changeset = put_change(changeset, :longitude, result["lng"])
            put_change(changeset, :latitude, result["lat"])
        end
      _ ->
        changeset
    end
  end

  defp fetch_coords(post_code) do
    request = HTTPoison.get("#{@api_uri}?address=#{post_code}&key=#{@api_key}")

    case request do
      {:ok, %HTTPoison.Response{body: body}} ->
        parsed = Poison.Parser.parse!(body)
        [address_components] = parsed["results"]
        {:ok, address_components["geometry"]["location"]}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
