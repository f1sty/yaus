defmodule Yaus.LinkController do
  use Yaus.Web, :controller
  alias Yaus.Link
  alias Yaus.Api.Link, as: LinkApi
  plug :authenticate

  def edit(conn, %{"link_id" => link_id}) do
    linkq = Repo.get_by(Link, link_id: link_id)
    render conn, link: Map.get(linkq, :redirect_url), short_url: main_page_url(conn, :index) <> Map.get(linkq, :link_id), link_id: Map.get(linkq, :link_id)
  end

  def delete(conn, %{"link_id" => link_id}) do
    case LinkApi.delete(link_id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Link was deleted")
        |> redirect(to: shortener_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something gone wrong:(")
        |> redirect(to: shortener_path(conn, :index))
    end
  end

  def redirect_to(conn, %{"link_id" => link_id}) do
    link = Repo.get_by(Link, link_id: link_id)
    case link do
      nil -> 
        conn
        |> put_flash(:error, "Wrong shortened link")
        |> redirect(to: shortener_path(conn, :index))
      _   ->
        conn
        |> redirect(external: Map.get(link, :redirect_url))
    end
  end

  defp authenticate(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn 
        |> put_flash(:info, "You must be logged in") 
        |> redirect(to: "/") 
        |> halt
      _   ->
        conn
    end
  end
end
