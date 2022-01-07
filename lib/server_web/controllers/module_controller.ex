defmodule ServerWeb.ModuleController do
  use ServerWeb, :controller

  alias Server.{Repo, Module, ModuleQuery}

  def index(conn, _params) do
    current_user = conn.assigns.current_user

    case ModuleQuery.fetchAllModulesByUserId(current_user.id) do
      {:ok, modules} ->
        render(conn, "index.json", modules: modules)

      {_, :no_module} ->
        conn
        |> send_resp(400, "error")
        |> halt
    end
  end

  def create(conn, %{"serial_number" => serial_number}) do
    with {:ok, module} <- Repo.insert(%Module{serial_id: serial_number, name: ""}),
         assoc_module <- Ecto.build_assoc(module, :config, %{}),
         {:ok, config} <- Repo.insert(assoc_module) do
      conn
      |> render("create.json", config: config)
    else
      {_, changeset} ->
        conn
        |> send_resp(400, changeset)
        |> halt
    end
  end

  def update(conn, %{"id" => id, "module" => module}) do
    current_user = conn.assigns.current_user
    changeset = Module.update_changeset(%Module{}, module)
    with {:ok, fetched} <- ModuleQuery.get_user_module(id, current_user.id),
         changed_module <- Ecto.Changeset.change(fetched, changeset.changes),
         {:ok, updated} <- Repo.update(changed_module) do
      conn
      |> json(updated)
    else
      {_, :no_module} ->
        conn
        |> send_resp(204, [])

      {:error, changeset} ->
        conn
        |> send_resp(400, changeset.errors)
        |> halt
    end
  end

  # def delete(conn, %{"current_user" => _current_user, "module" => module}) do
  #   case Repo.delete(Module, module.module_id) do
  #     {:ok, _} ->
  #       conn
  #       |> send_resp(200, :deleted)

  #     {:error, _} ->
  #       conn
  #       |> send_resp(400, :no_deleted)
  #   end
  # end

  def connect(conn, %{"module_serial_number" => serial_number}) do
    current_user = conn.assigns.current_user

    case ModuleQuery.create_user_module_assoc(current_user.id, serial_number) do
      {:ok, _} ->
        conn |> send_resp(201, "OK")
      _ ->
        conn
        |> send_resp(406, "OUCH")
        |> halt
    end
  end
end
