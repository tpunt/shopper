defmodule Shopper.PostCodeTest do
  use Shopper.ModelCase

  alias Shopper.PostCode

  @valid_attrs %{latitude: "120.5", longitude: "120.5", post_code: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostCode.changeset(%PostCode{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostCode.changeset(%PostCode{}, @invalid_attrs)
    refute changeset.valid?
  end
end
