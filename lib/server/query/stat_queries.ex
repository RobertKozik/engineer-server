defmodule Server.StatsQuery do
  import Ecto.Query
  import Ecto.Changeset
  import Logger
  alias Server.{Module, Repo, StatEntry, ModuleQuery}
  require String

  def insert_value(type, value, module_serial) do

    case ModuleQuery.fetch_module_by_serial_id(module_serial) do
    {:ok, module} ->
      type = String.to_atom(type)
      entry = Ecto.build_assoc(module, :stats, %StatEntry{type: type, value: value})
      Repo.insert(entry)
    _ -> {:error, "Unable to find module with such serial id"}
    end
  end

  def get_all_stats_by_module(module_serial, from, interval) do
    query = from s in StatEntry,
            join: m in Module,
            on: m.id == s.module_id,
            where: s.inserted_at > ago( ^from, ^interval),
            where: m.serial_id == ^module_serial

    Repo.all query
  end

  def get_all_stats_by_module_and_type(module_serial, stat_type, from, interval) do
    atom_type = String.to_existing_atom(stat_type)
    query = from s in StatEntry,
            join: m in Module,
            on: m.id == s.module_id,
            where: m.serial_id == ^module_serial,
            where: s.type == ^atom_type,
            where: s.inserted_at > ago( ^from, ^interval)

    Repo.all query
  end



end
