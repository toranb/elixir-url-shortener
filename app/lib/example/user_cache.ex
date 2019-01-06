defmodule Example.UserCache do
  use GenServer

  alias Example.Users

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:user_cache))
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
    state = for %Example.User{id: id, username: key, hash: value} <- Users.all(), into: %{}, do: {id, {key, value}}
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:put, key, {username, hash}}, state) do
    Users.create_user(%{id: key, username: username, hash: hash})
    {:noreply, Map.put(state, key, {username, hash})}
  end
end
