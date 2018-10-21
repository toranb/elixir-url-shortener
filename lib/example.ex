defmodule EX.Application do
  use Application

  def start(_type, _args) do
    EX.Worker.start_link(name: EX.Worker)
  end
end
