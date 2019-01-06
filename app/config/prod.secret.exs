use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :example, ExampleWeb.Endpoint,
  secret_key_base: "F49z7EUr1xyHZVwXUb6ijtJDrihpRO1uwMlY0Lrz3cuFtwM98aygv8yx8VDH4xfv"

# Configure your database
config :example, Example.Repo,
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: System.get_env("POSTGRES_DB"),
  hostname: System.get_env("POSTGRES_HOST"),
  pool_size: 15
