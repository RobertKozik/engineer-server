defmodule Server.Repo.Migrations.CreateModules do
  use Ecto.Migration

  def change do
    create table(:modules) do
      add :name, :string
      add :serial_id, :string

      timestamps()
    end
    create unique_index(:modules, [:serial_id])
  end
end
