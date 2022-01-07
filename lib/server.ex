defmodule Server do
  require Protocol

  Protocol.derive(Jason.Encoder, Server.Config,
    only: [:sampling_rate, :temperature_sensor, :soil_humidity_sensor, :light_sensor]
  )

  Protocol.derive(Jason.Encoder, Server.Module,
    only: [:name, :serial_id, :config, :inserted_at]
  )

  Protocol.derive(Jason.Encoder, Server.User,
    only: [:name, :email]
  )

  Protocol.derive(Jason.Encoder, Server.StatEntry,
    only: [:type, :value, :inserted_at, :module_id]
  )

  @moduledoc """
  Server keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
end
