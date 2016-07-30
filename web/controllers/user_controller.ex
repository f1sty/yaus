defmodule Yaus.UserController do
  @moduledoc """
  User sruff
  """
  use Yaus.Web, :controller
  alias Yaus.User
  alias Yaus.Api.User, as: UserApi

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    case UserApi.add(user_params) do
      {:ok, changeset} ->
        conn
        |> put_session(:user_id, changeset.id)
        |> put_flash(:info, "Account succesfully created")
        |> redirect(to: main_page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to create an account")
        |> redirect(to: user_path(conn, :new))
    end
  end
end
