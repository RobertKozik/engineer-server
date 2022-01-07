defmodule ServerWeb.ModuleView do
  use ServerWeb, :view

  def render("index.json", %{modules: modules}) do
    %{
      data:
        Enum.map(modules, fn module ->
          %{
            serial_id: module.serial_id,
            name: module.name,
            id: module.id,
            config: module.config,
            inserted_at: module.inserted_at
            # %{
            #   sampling_rate: module.config.sampling_rate,
            #   temperature_sensor: module.config.temperature_sensor,
            #   soil_humidity_sensor: module.config.soil_humidity_sensor,
            #   light_sensor: module.config.light_sensor
            # }
          }
        end)
    }
  end

  def render("create.json", %{config: config}) do
    %{id: config.module_id}
  end
end
