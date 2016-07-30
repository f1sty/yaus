defmodule Yaus.Api.User do
  import Ecto.Changeset, only: [put_change: 3]
  alias Yaus.User
  alias Yaus.Repo
  alias Comeonin.Bcrypt

  def add(user_params) do
    changeset = User.changeset(%User{}, user_params)
    register(changeset)
  end

  def login(user_params) do
    user = Repo.get_by(User, username: user_params["username"])
    case auth(user, user_params["password"]) do
      true -> {:ok, user.id}
      _    -> :error
    end
  end

  defp register(changeset) do
    changeset
    |> put_change(:crypted_password, hash_password(changeset.params["password"]))
    |> Repo.insert()
  end

  defp hash_password(password) do
    Bcrypt.hashpwsalt(password)
  end

  defp auth(user, password) do
    case user do
      nil -> false
      _   -> Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end
