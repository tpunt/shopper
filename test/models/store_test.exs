defmodule Shopper.StoreTest do
  use Shopper.ModelCase

  alias Shopper.Store

  @valid_attrs %{store_open_date: "2010-04-17"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Store.changeset(%Store{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Store.changeset(%Store{}, @invalid_attrs)
    refute changeset.valid?
  end
end
