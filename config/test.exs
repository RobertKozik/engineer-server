import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :server, Server.Repo,
  username: "edb_admin",
  password: "rxIaDlCZJy8aHx1dFXpvDmp5EAqI6xkD",
  database: "edb",
  hostname: "frankfurt-postgres.render.com",
  port: 5432,
  ssl: true,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :server, ServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "kvfNTOPJW0pWTdaS8IKmoSwRXZB8rOqSSrsNeC8l3bZRrM8I/iOqzz8HLnIcJ4MI",
  server: false

# In test we don't send emails.
config :server, Server.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
