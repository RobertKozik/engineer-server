defmodule ServerWeb.SessionController do
  use ServerWeb, :controller

  import Ecto.Query

  alias Server.{Token, User, Repo}

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- authenticateUser(email, password) do
      token = Token.sign(user.id)
      conn|>json(%{token: token})
    else
      _ ->
        conn
        |> send_resp(403, "wrong credintials")
        |> halt
    end
  end

  def register(conn, %{"email" => email_, "password" => password_, "name" => name_}) do
    checked_user = User.changeset(%User{}, %{email: email_, name: name_, password_hash: password_})

    case Repo.insert(checked_user) do
      {:ok, inserted_user} ->
        render(conn, "create.json", user: inserted_user)

      {_, _changeset} ->
        conn
        |> send_resp(403, "user exists")
        |> halt
    end
  end

  def authenticateUser(email, password) do
    query = from User, where: [email: ^email]

    case Repo.one(query) do
      nil -> {:error, "no user"}
      user -> Comeonin.Bcrypt.check_pass(user, password)
    end
  end
end
