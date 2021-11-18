defmodule Server.Config do
  use Ecto.Schema

  schema "distributors" do
    field :name, :string
    field :sampling_rate, :integer
    field :temperature_sensor, :boolean
    field :soil_humidity_sensor, :boolean
    field :light_sensor, :boolean

    belongs_to :module, Server.Module
  end
end
