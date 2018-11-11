defmodule Example.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(ExampleWeb.Endpoint, []),
      {Registry, keys: :unique, name: Example.Registry},
      Example.Cache,
      Example.UserCache,
      Example.Worker,
      Example.User
    ]

    opts = [strategy: :one_for_one, name: Example.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
