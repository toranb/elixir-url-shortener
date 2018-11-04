defmodule Example.Cache do
  use GenServer

  @database "./database"

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: via(:cache))
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
    files = list_files()
    state =
      Enum.map(files, &tuple_from_filesystem/1)
      |> Enum.into(%{})
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    @database
      |> file_name(key)
      |> File.write!(:erlang.term_to_binary(value))
    {:noreply, Map.put(state, key, value)}
  end

  defp list_files() do
    case :file.list_dir(@database) do
      {:ok, files} -> files
      {:error, _} -> []
    end
  end

  defp tuple_from_filesystem(key) do
    {:ok, contents} = File.read(file_name(@database, key))
    {key, :erlang.binary_to_term(contents)}
  end

  defp file_name(database, key) do
    Path.join(database, to_string(key))
  end
end
