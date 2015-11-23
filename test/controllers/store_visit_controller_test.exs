defmodule Shopper.StoreVisitControllerTest do
  use Shopper.ConnCase

  alias Shopper.StoreVisit
  @valid_attrs %{distance_travelled: "120.5", visit_date: "2010-04-17"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, store_visit_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    store_visit = Repo.insert! %StoreVisit{}
    conn = get conn, store_visit_path(conn, :show, store_visit)
    assert json_response(conn, 200)["data"] == %{"id" => store_visit.id,
      "customer_id" => store_visit.customer_id,
      "store_id" => store_visit.store_id,
      "visit_date" => store_visit.visit_date,
      "distance_travelled" => store_visit.distance_travelled}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, store_visit_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, store_visit_path(conn, :create), store_visit: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(StoreVisit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, store_visit_path(conn, :create), store_visit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    store_visit = Repo.insert! %StoreVisit{}
    conn = put conn, store_visit_path(conn, :update, store_visit), store_visit: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(StoreVisit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    store_visit = Repo.insert! %StoreVisit{}
    conn = put conn, store_visit_path(conn, :update, store_visit), store_visit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    store_visit = Repo.insert! %StoreVisit{}
    conn = delete conn, store_visit_path(conn, :delete, store_visit)
    assert response(conn, 204)
    refute Repo.get(StoreVisit, store_visit.id)
  end
end
