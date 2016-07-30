defmodule Yaus.User do
  use Yaus.Web, :model

  schema "users" do
    field :username, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    has_many :links, Yaus.Link

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :password, :crypted_password])
    |> validate_required([:username, :password])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:username)
  end
end
