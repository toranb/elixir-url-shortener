defmodule EX.Application do
  use Application

  def start(_type, _args) do
    EX.Supervisor.start_link(name: EX.Supervisor)
  end
end
