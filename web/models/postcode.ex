defmodule Shopper.Postcode do
  # use Shopper.Web, model: Ecto.Changeset
  import Ecto.Changeset

  @geocode_uri "https://maps.googleapis.com/maps/api/geocode/json"
  @api_key "AIzaSyDyILl9XSufn-8KHEvZ9StZuuRlwsTqmJw" # put in mix.exs?

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def postcode_changeset(model, _params \\ :empty) do
    model
    |> validate_length(:postcode, min: 6, max: 8)
  end

  def postcode_coords_changeset(model, params) do
    model
    |> postcode_changeset(params)
    |> get_postcode_coords()
  end

  defp get_postcode_coords(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{postcode: postcode}} ->
        case fetch_coords(postcode) do
          {:ok, result} ->
            changeset = put_change(changeset, :longitude, result["lng"])
            put_change(changeset, :latitude, result["lat"])
          _ ->
            # log here
            changeset
        end
      _ ->
        # log here
        changeset
    end
  end

  defp fetch_coords(postcode) do
    request = HTTPoison.get("#{@geocode_uri}?address=#{postcode}&key=#{@api_key}")

    case request do
      {:ok, %HTTPoison.Response{body: body}} ->
        case Poison.Parser.parse!(body) do
          %{"results" => [%{"geometry" => %{"location" => location}}]} ->
            {:ok, location}
          _ -> {:error, "No results"}
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
