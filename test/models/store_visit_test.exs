defmodule Shopper.StoreVisitTest do
  use Shopper.ModelCase

  alias Shopper.StoreVisit

  @valid_attrs %{distance_travelled: "120.5", visit_date: "2010-04-17"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = StoreVisit.changeset(%StoreVisit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = StoreVisit.changeset(%StoreVisit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
