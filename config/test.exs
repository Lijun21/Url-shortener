import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :url_shortener, UrlShortenerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "tVg0Aqvd/af17Zjc1tpYqa2Q2Obm0NIPeYvooWxgEL+XMjJzcrWnOGkKQZfwAjMh",
  server: false

# In test we don't send emails.
config :url_shortener, UrlShortener.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

config :url_shortener, UrlShortener.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PSQL_DB_USER_NAME"),
  password: System.get_env("PSQL_DB_USER_PW"),
  database: System.get_env("PSQL_DB_NAME"),
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
