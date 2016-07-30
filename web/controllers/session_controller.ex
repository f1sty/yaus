defmodule Yaus.SessionController do
  @moduledoc """
  Manage to login/logout user
  """
  use Yaus.Web, :controller
  alias Yaus.User
  alias Yaus.Api.User, as: UserApi

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def login(conn, %{"user" => user_params}) do
    case UserApi.login(user_params) do
      {:ok, user_id} ->
        conn
        |> put_session(:user_id, user_id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: main_page_path(conn, :index))
      :error ->
        conn
        |> put_flash(:error, "Unable to login")
        |> redirect(to: session_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> Plug.Conn.delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: main_page_path(conn, :index))
  end
end
