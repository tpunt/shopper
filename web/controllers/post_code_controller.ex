defmodule Shopper.PostCodeController do
  use Shopper.Web, :controller

  alias Shopper.PostCode

  plug :scrub_params, "post_code" when action in [:create, :update]

  def index(conn, _params) do
    postcodes = Repo.all(PostCode)
    render(conn, "index.json", postcodes: postcodes)
  end

  def create(conn, %{"post_code" => post_code_params}) do
    changeset = PostCode.changeset(%PostCode{}, post_code_params)

    case Repo.insert(changeset) do
      {:ok, post_code} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", post_code_path(conn, :show, post_code))
        |> render("show.json", post_code: post_code)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Shopper.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post_code = Repo.get!(PostCode, id)
    render(conn, "show.json", post_code: post_code)
  end

  def update(conn, %{"id" => id, "post_code" => post_code_params}) do
    post_code = Repo.get!(PostCode, id)
    changeset = PostCode.changeset(post_code, post_code_params)

    case Repo.update(changeset) do
      {:ok, post_code} ->
        render(conn, "show.json", post_code: post_code)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Shopper.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post_code = Repo.get!(PostCode, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post_code)

    send_resp(conn, :no_content, "")
  end
end
