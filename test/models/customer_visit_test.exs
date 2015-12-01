defmodule Shopper.CustomerVisitTest do
  use Shopper.ModelCase

  alias Shopper.CustomerVisit

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CustomerVisit.changeset(%CustomerVisit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CustomerVisit.changeset(%CustomerVisit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
