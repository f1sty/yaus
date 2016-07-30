defmodule Yaus.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :link_id, :string
      add :redirect_url, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create unique_index(:links, [:redirect_url])
    create index(:links, [:user_id])

  end
end
