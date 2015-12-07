defmodule Shopper.PostcodeControllerTest do
  use Shopper.ConnCase

  alias Shopper.Postcode
  @valid_attrs %{latitude: "120.5", longitude: "120.5", postcode: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, postcode_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    postcode = Repo.insert! %Postcode{}
    conn = get conn, postcode_path(conn, :show, postcode)
    assert json_response(conn, 200)["data"] == %{"id" => postcode.id,
      "postcode" => postcode.postcode,
      "longitude" => postcode.longitude,
      "latitude" => postcode.latitude}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, postcode_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, postcode_path(conn, :create), postcode: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Postcode, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, postcode_path(conn, :create), postcode: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    postcode = Repo.insert! %Postcode{}
    conn = put conn, postcode_path(conn, :update, postcode), postcode: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Postcode, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    postcode = Repo.insert! %Postcode{}
    conn = put conn, postcode_path(conn, :update, postcode), postcode: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    postcode = Repo.insert! %Postcode{}
    conn = delete conn, postcode_path(conn, :delete, postcode)
    assert response(conn, 204)
    refute Repo.get(Postcode, postcode.id)
  end
end
