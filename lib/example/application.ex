defmodule EX.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      {Registry, keys: :unique, name: EX.Registry},
      EX.Cache,
      EX.Worker
    ]

    opts = [strategy: :one_for_one, name: EX.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
