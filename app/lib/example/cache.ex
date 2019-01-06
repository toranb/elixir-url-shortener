defmodule Example.Cache do
  use GenServer

  alias Example.Links

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:cache))
  end

  defp via(name), do: Example.Registry.via(name)

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
  def handle_call({:all}, _timeout, _state) do
    state = for %Example.Link{hash: key, url: value} <- Links.all(), into: %{}, do: {key, value}
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    Links.create_link(%{hash: key, url: value})
    {:noreply, Map.put(state, key, value)}
  end
end
