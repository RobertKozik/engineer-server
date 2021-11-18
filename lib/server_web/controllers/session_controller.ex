defmodule ServerWeb.SessionController do
  use ServerWeb, :controller

  import Ecto.Query

  alias Server.{Token, User, Repo}

  def new(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- authenticateUser(email, password) do
      token = Token.sign(user.id)
      render(conn, "new.json", token: token)
    else
      _ ->
        conn
        |> send_resp(403, "wrong credintials")
        |> halt
    end
  end

  def authenticateUser(email, password) do
    query = from User, where: [email: ^email], where: [password: ^password]

    case Repo.one(query) do
      nil -> {:error, "no user"}
      user -> {:ok, user}
    end
  end
end
