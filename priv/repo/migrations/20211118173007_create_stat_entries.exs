defmodule Server.Repo.Migrations.CreateStatEntries do
  use Ecto.Migration

  def change do
    create table(:stat_entries) do
      add :type, :string
      add :value, :float
      add :module_id, references(:modules)

      timestamps()
    end

    create unique_index(:stat_entries, [:module_id])
  end
end
