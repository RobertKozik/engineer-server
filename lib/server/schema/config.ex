defmodule Server.Config do
  use Ecto.Schema
  import Ecto.Changeset

  schema "configs" do
    field :sampling_rate, :integer, default: 5
    field :temperature_sensor, :boolean, default: :true
    field :soil_humidity_sensor, :boolean, default: :true
    field :light_sensor, :boolean, default: :true

    belongs_to :module, Server.Module
  end

  def changeset(config, attrs) do
    config
    |> cast(attrs, [:sampling_rate, :temperature_sensor, :soil_humidity_sensor, :light_sensor])
    |> validate_required([:sampling_rate, :temperature_sensor, :soil_humidity_sensor, :light_sensor])
  end
end
