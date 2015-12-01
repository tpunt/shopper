defmodule Shopper.StoreVisitController do
  use Shopper.Web, :controller

  alias Shopper.StoreVisit

  plug :scrub_params, "store_visit" when action in [:create, :update]

  def index(conn, _params) do
    storevisits = Repo.all(StoreVisit)
    IO.inspect storevisits
    render(conn, "index.json", storevisits: storevisits)
  end

  def create(conn, %{"store_visit" => store_visit_params}) do
    changeset = StoreVisit.distance_travelled_changeset(%StoreVisit{}, store_visit_params)

    case Repo.insert(changeset) do
      {:ok, store_visit} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", store_visit_path(conn, :show, store_visit))
        |> render("show.json", store_visit: store_visit)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Shopper.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    store_visit = Repo.get!(StoreVisit, id)
    render(conn, "show.json", store_visit: store_visit)
  end

  def update(conn, %{"id" => id, "store_visit" => store_visit_params}) do
    store_visit = Repo.get!(StoreVisit, id)
    changeset = StoreVisit.changeset(store_visit, store_visit_params)

    case Repo.update(changeset) do
      {:ok, store_visit} ->
        render(conn, "show.json", store_visit: store_visit)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Shopper.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    store_visit = Repo.get!(StoreVisit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(store_visit)

    send_resp(conn, :no_content, "")
  end
end
