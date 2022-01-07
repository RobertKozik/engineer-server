defmodule Server.ConfigQuery do
  alias Server.{Repo, Config}
  require Logger

  @spec get_by_module_serial_id(any) :: {:error, <<_::120>>} | {:ok, any}
  def get_by_module_serial_id(id) do
    case Repo.get_by(Config, module_id: id) do
      nil -> {:error, "no module found"}
      module -> {:ok, module}
    end
  end

  def updateConfig(config, module_id) do
    with {:ok, fetched} <- get_by_module_serial_id(module_id),
         changeset = Config.changeset(fetched, config),
         changed_config <- Ecto.Changeset.change(fetched, changeset.changes),
         {:ok, updated} <- Repo.update(changed_config) do

      {:ok, updated}
    else
      {:error, why} ->
        {:error, why}
    end
  end
end
