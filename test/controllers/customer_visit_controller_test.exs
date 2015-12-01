defmodule Shopper.CustomerVisitControllerTest do
  use Shopper.ConnCase

  alias Shopper.CustomerVisit
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, customer_visit_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    customer_visit = Repo.insert! %CustomerVisit{}
    conn = get conn, customer_visit_path(conn, :show, customer_visit)
    assert json_response(conn, 200)["data"] == %{"id" => customer_visit.id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, customer_visit_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, customer_visit_path(conn, :create), customer_visit: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CustomerVisit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, customer_visit_path(conn, :create), customer_visit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    customer_visit = Repo.insert! %CustomerVisit{}
    conn = put conn, customer_visit_path(conn, :update, customer_visit), customer_visit: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CustomerVisit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    customer_visit = Repo.insert! %CustomerVisit{}
    conn = put conn, customer_visit_path(conn, :update, customer_visit), customer_visit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    customer_visit = Repo.insert! %CustomerVisit{}
    conn = delete conn, customer_visit_path(conn, :delete, customer_visit)
    assert response(conn, 204)
    refute Repo.get(CustomerVisit, customer_visit.id)
  end
end
