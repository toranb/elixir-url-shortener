defmodule Example.Registry do
  def via(name) do
    {:via, Registry, {__MODULE__, {name}}}
  end
end
