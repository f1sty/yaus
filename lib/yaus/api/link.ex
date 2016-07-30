defmodule Yaus.Api.Link do
  import Plug.Conn, only: [get_session: 2]
  alias Yaus.Short
  alias Yaus.Repo
  alias Yaus.Link

  def add(conn, link_params) do
    user_id = get_session(conn, :user_id)
    short_url = Short.hash_url(link_params["redirect_url"], user_id)
    link = link_params
    |> Map.put("link_id", short_url)
    |> Map.put("user_id", user_id)
    Link.changeset(%Link{}, link)
    |> Repo.insert
  end

  def delete(link_id) do
    Link
    |> Repo.get_by(link_id: link_id)
    |> Repo.delete
  end
end
