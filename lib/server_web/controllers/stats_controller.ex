defmodule ServerWeb.StatsController do
  use ServerWeb, :controller
  require Logger
  alias Server.StatsQuery

  def create(conn, %{"id" => module_id, "type" => type, "value" => value}) do
    case StatsQuery.insert_value(type, value, module_id) do
    {:ok, inserted} ->
      conn |> json(inserted)
    {:error, why} ->
      conn |> json(%{error: why})
    end
  end

  def stats(conn, %{"module_id" => module_id}) do
    Logger.debug(conn.params)
    type = Map.get(conn.params, "type", :no_type)
    {from, _} = Map.get(conn.params, "from", "1") |> Integer.parse()
    interval = Map.get(conn.params, "interval", "day")
    case type do
      :no_type ->
        stats = StatsQuery.get_all_stats_by_module(module_id, from, interval)

        conn
        |> put_status(:ok)
        |> json(stats)

      _ ->
        stats = StatsQuery.get_all_stats_by_module_and_type(module_id, type, from, interval)

        conn
        |> put_status(:ok)
        |> json(stats)
    end
  end
end
