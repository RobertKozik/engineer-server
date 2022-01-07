defmodule ServerWeb.ConfigController do
  use ServerWeb, :controller
  alias Server.ConfigQuery

  def update(conn, %{"module_id" => id, "config" => config}) do
    case ConfigQuery.updateConfig(config, id) do
      {:ok, updated} -> conn |> json(updated)
      {:error, why} -> conn |> json(%{error: why})
    end
  end
end
