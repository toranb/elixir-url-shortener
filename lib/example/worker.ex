defmodule Example.Worker do
  use GenServer

  alias Example.Shortener

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:worker))
  end

  defp via(name), do: Example.Registry.via(name)

  @impl GenServer
  def init(:ok) do
    state = Example.Cache.all(:cache)
    {:ok, state, {:continue, :init}}
  end

  @impl GenServer
  def handle_continue(:init, state) do
    {:noreply, state}
  end

  def get(name, hash) do
    GenServer.call(via(name), {:get, hash})
  end

  def put(name, url) do
    GenServer.call(via(name), {:put, url})
  end

  @impl GenServer
  def handle_call({:get, hash}, _timeout, state) do
    {:reply, Shortener.get_url(state, hash), state}
  end

  @impl GenServer
  def handle_call({:put, url}, _timeout, state) do
    {new_state, {key, value}} = Example.Shortener.create_short_url(state, url)
    Example.Cache.put(:cache, key, value)
    {:reply, {key, value}, new_state}
  end
end
