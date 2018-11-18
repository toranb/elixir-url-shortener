defmodule Example.User do
  use GenServer

  alias Example.Hash
  alias Example.Password
  alias Example.FindUser
  alias Example.UserCache

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:user))
  end

  defp via(name), do: Example.Registry.via(name)

  @impl GenServer
  def init(:ok) do
    state = UserCache.all(:user_cache)
    {:ok, state, {:continue, :init}}
  end

  @impl GenServer
  def handle_continue(:init, state) do
    {:noreply, state}
  end

  def get(name, id) do
    GenServer.call(via(name), {:get, id})
  end

  def get_by_username_and_password(name, username, password) do
    GenServer.call(via(name), {:get, username, password})
  end

  def put(name, username, password) do
    GenServer.call(via(name), {:put, username, password})
  end

  @impl GenServer
  def handle_call({:get, id}, _timeout, state) do
    {username, _} = Map.get(state, id)
    {:reply, username, state}
  end

  @impl GenServer
  def handle_call({:get, username, password}, _timeout, state) do
    username = FindUser.with_username_and_password(state, username, password)
    {:reply, username, state}
  end

  @impl GenServer
  def handle_call({:put, username, password}, _timeout, state) do
    hash = Password.hash(password)
    id = Hash.hmac("type:user", username)
    new_state = Map.put(state, id, {username, hash})
    UserCache.put(:user_cache, id, {username, hash})
    {:reply, {id, username}, new_state}
  end
end
