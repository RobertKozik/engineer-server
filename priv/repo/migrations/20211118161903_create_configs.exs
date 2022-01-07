defmodule Server.Repo.Migrations.CreateConfigs do
  use Ecto.Migration

  def change do
    create table(:configs) do
      add :sampling_rate, :integer
      add :temperature_sensor, :boolean
      add :soil_humidity_sensor, :boolean
      add :light_sensor, :boolean
      add :module_id, references(:modules)
    end

    create unique_index(:configs, [:module_id])
  end
end
