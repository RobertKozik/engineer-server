defmodule Server.StatEntry do
  use Ecto.Schema

  schema "stat_entries" do
    field :type, Ecto.Enum, values: [:temperature_sensor, :soil_humidity_sensor, :light_sensor]
    field :value, :float

    timestamps()
    belongs_to :module, Server.Module
  end
end
