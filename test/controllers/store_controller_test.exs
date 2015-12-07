defmodule Shopper.StoreControllerTest do
  use Shopper.ConnCase

  alias Shopper.Store
  @valid_attrs %{store_open_date: "2010-04-17"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, store_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = get conn, store_path(conn, :show, store)
    assert json_response(conn, 200)["data"] == %{"id" => store.id,
      "store_postcode_id" => store.store_postcode_id,
      "store_open_date" => store.store_open_date}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, store_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, store_path(conn, :create), store: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Store, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, store_path(conn, :create), store: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = put conn, store_path(conn, :update, store), store: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Store, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = put conn, store_path(conn, :update, store), store: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = delete conn, store_path(conn, :delete, store)
    assert response(conn, 204)
    refute Repo.get(Store, store.id)
  end
end
