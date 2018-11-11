defmodule Example.UserCache do
  use GenServer

  import Example.File, only: [write: 3, read: 1]

  @database "./database/user"

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:user_cache))
  end

  defp via(name), do: Example.Registry.via(name)

  @impl GenServer
  def init(:ok) do
    File.mkdir_p!(@database)
    {:ok, %{}, {:continue, :init}}
  end

  @impl GenServer
  def handle_continue(:init, state) do
    {:noreply, state}
  end

  def all(name) do
    GenServer.call(via(name), {:all})
  end

  def put(name, key, value) do
    GenServer.cast(via(name), {:put, key, value})
  end

  @impl GenServer
  def handle_call({:all}, _timeout, _state) do
    state = read(@database)
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    write(@database, key, value)
    {:noreply, Map.put(state, key, value)}
  end
end
