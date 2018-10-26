defmodule EX.Cache do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:cache))
  end

  defp via(name), do: EX.Registry.via(name)

  @impl GenServer
  def init(:ok) do
    {:ok, %{}}
  end

  def all(name) do
    GenServer.call(via(name), {:all})
  end

  def put(name, key, value) do
    GenServer.cast(via(name), {:put, key, value})
  end

  @impl GenServer
  def handle_call({:all}, _timeout, state) do
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end
end
