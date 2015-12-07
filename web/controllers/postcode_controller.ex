defmodule Shopper.PostcodeController do
  use Shopper.Web, :controller

  alias Shopper.Postcode

  plug :scrub_params, "postcode" when action in [:create, :update]

  def index(conn, _params) do
    postcodes = Repo.all(Postcode)
    render(conn, "index.json", postcodes: postcodes)
  end

  def create(conn, %{"postcode" => postcode_params}) do
    changeset = Postcode.postcode_coords_changeset(%Shopper.Customer{}, postcode_params)

    case Repo.insert(changeset) do
      {:ok, postcode} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", postcode_path(conn, :show, postcode))
        |> render("show.json", postcode: postcode)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Shopper.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    postcode = Repo.get!(Postcode, id)
    render(conn, "show.json", postcode: postcode)
  end

  def update(conn, %{"id" => id, "postcode" => postcode_params}) do
    postcode = Repo.get!(Postcode, id)
    changeset = Postcode.changeset(postcode, postcode_params)

    case Repo.update(changeset) do
      {:ok, postcode} ->
        render(conn, "show.json", postcode: postcode)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Shopper.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    postcode = Repo.get!(Postcode, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(postcode)

    send_resp(conn, :no_content, "")
  end
end
