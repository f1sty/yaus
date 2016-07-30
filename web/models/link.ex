defmodule Yaus.Link do
  use Yaus.Web, :model

  schema "links" do
    field :link_id, :string
    field :redirect_url, :string
    belongs_to :user, Yaus.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:link_id, :redirect_url, :user_id])
    |> validate_required([:link_id, :redirect_url, :user_id])
    |> unique_constraint(:redirect_url)
  end
end
