defmodule Shopper.PostcodeTest do
  use Shopper.ModelCase

  alias Shopper.Postcode

  @valid_attrs %{latitude: "120.5", longitude: "120.5", postcode: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Postcode.changeset(%Postcode{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Postcode.changeset(%Postcode{}, @invalid_attrs)
    refute changeset.valid?
  end
end
