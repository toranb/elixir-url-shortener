defmodule EX.Worker do
  use GenServer

  alias EX.Shortener

  def start_link(args) do
    GenServer.start_link(__MODULE__, :ok, args)
  end

  @impl GenServer
  def init(:ok) do
    state = Shortener.new()
    {:ok, state}
  end

  def get(pid, hash) do
    GenServer.call(pid, {:get, hash})
  end

  def put(pid, hash, url) do
    GenServer.cast(pid, {:put, hash, url})
  end

  @impl GenServer
  def handle_call({:get, hash}, _timeout, state) do
    {:reply, Shortener.get_url(state, hash), state}
  end

  @impl GenServer
  def handle_cast({:put, hash, url}, state) do
    new_state = Shortener.create_short_url(state, hash, url)
    {:noreply, new_state}
  end
end
