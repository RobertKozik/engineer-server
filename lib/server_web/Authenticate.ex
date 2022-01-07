defmodule ServerWeb.Authenticate do
  import Plug.Conn
  require Logger

  alias Server.User

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Server.Token.verify(token),
         {:ok, user} <- get_user(data) do
      conn
      |> assign(:current_user, user)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(ServerWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end

  defp get_user(id) do
    case Server.Repo.get(User, id) do
      nil -> {:error, :no_user}
      user -> {:ok, user}
    end
  end
end
