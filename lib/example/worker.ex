defmodule EX.Worker do
  use GenServer

  alias EX.Shortener

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:worker))
  end

  defp via(name), do: EX.Registry.via(name)

  @impl GenServer
  def init(:ok) do
    state = EX.Cache.all(:cache)
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
    {new_state, {key, value}} = EX.Shortener.create_short_url(state, url)
    EX.Cache.put(:cache, key, value)
    {:reply, {key, value}, new_state}
  end
end
