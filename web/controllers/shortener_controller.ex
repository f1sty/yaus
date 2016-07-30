defmodule Yaus.ShortenerController do
  import Yaus.Repo
  use Yaus.Web, :controller
  alias Yaus.Link
  alias Yaus.Api.Link, as: LinkApi
  plug :authenticate

  def create(conn, %{"link" => link_params}) do
    case LinkApi.add(conn, link_params) do
      {:ok, changeset} ->
        conn
        |> put_flash(:info, "New shortened url created: " <> main_page_url(conn, :index) <> changeset.link_id)
        |> redirect(to: shortener_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to create shortened url")
        |> redirect(to: shortener_path(conn, :index))
    end
  end

  def index(conn, _params) do
    changeset = Link.changeset(%Link{})
    query = from Link, where: [user_id: ^get_session(conn, :user_id)], order_by: [desc: :inserted_at], select: [:redirect_url, :link_id]
    links = all(query)
    render conn, links: links, changeset: changeset
  end

  defp authenticate(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn |> put_flash(:info, "You must be logged in") |> redirect(to: "/") |> halt
      _   ->
        conn
    end
  end
end
