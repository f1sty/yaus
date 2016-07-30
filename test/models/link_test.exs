defmodule Yaus.LinkTest do
  use Yaus.ModelCase

  alias Yaus.Link

  @valid_attrs %{redirect_url: "some content", short_url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Link.changeset(%Link{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Link.changeset(%Link{}, @invalid_attrs)
    refute changeset.valid?
  end
end
