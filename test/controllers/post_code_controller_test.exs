defmodule Shopper.PostCodeControllerTest do
  use Shopper.ConnCase

  alias Shopper.PostCode
  @valid_attrs %{latitude: "120.5", longitude: "120.5", post_code: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, post_code_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    post_code = Repo.insert! %PostCode{}
    conn = get conn, post_code_path(conn, :show, post_code)
    assert json_response(conn, 200)["data"] == %{"id" => post_code.id,
      "post_code" => post_code.post_code,
      "longitude" => post_code.longitude,
      "latitude" => post_code.latitude}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, post_code_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, post_code_path(conn, :create), post_code: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(PostCode, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, post_code_path(conn, :create), post_code: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    post_code = Repo.insert! %PostCode{}
    conn = put conn, post_code_path(conn, :update, post_code), post_code: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PostCode, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post_code = Repo.insert! %PostCode{}
    conn = put conn, post_code_path(conn, :update, post_code), post_code: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    post_code = Repo.insert! %PostCode{}
    conn = delete conn, post_code_path(conn, :delete, post_code)
    assert response(conn, 204)
    refute Repo.get(PostCode, post_code.id)
  end
end
