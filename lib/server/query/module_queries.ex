defmodule Server.ModuleQuery do
  import Ecto.Query
  alias Server.{Module, Repo, UserModule, User, UserModule}

  def fetch_module_by_serial_id(id) do
    case Repo.get_by(Module, serial_id: id) do
      nil -> {:error, :no_module}
      module -> {:ok, module}
    end
  end

  def fetchAllModulesByUserId(id) do
    query =
      from m in Module,
        join: u in UserModule,
        on: m.id == u.module_id,
        where: u.user_id == ^id,
        preload: [:config]

    modules = Repo.all(query)

    case length(modules) do
      0 -> {:error, :no_module}
      _ -> {:ok, modules}
    end
  end

  def get_user_module(module_id, user_id) do
    query =
      from m in Module,
        join: u in UserModule,
        on: m.id == u.module_id,
        where: u.user_id == ^user_id,
        where: m.serial_id == ^module_id,
        preload: [:config]

    # Logger.debug(Repo.one query)
    case Repo.one(query) do
      nil -> {:error, :no_module}
      module -> {:ok, module}
    end
  end

  def create_user_module_assoc(user_id, module_id) do
    user = Repo.preload(Repo.get(User, user_id), [:modules])
    module = Repo.preload(Repo.get_by(Module, serial_id: module_id), [:users])

    user_changeset = Ecto.Changeset.change(user)
    user_module_changeset = user_changeset |> Ecto.Changeset.put_assoc(:modules, user.modules ++ [module])
    Repo.update(user_module_changeset)
    # module = Repo.get_by(Module, serial_id: module_id)
    # user = Repo.get(User, user_id)
    # Repo.insert(%UserModule{user_id: user.id, module_id: module.id})
    # user
    # |> Repo.preload(:modules)
    # |> Ecto.Changeset.change()
    # |> Ecto.Changeset.put_assoc(:modules, user.modules ++ [module])
    # |> Repo.update!
  end
end
