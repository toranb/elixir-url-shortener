defmodule Example.File do
  def write(database, key, value) do
    database
      |> file_name(key)
      |> File.write!(:erlang.term_to_binary(value))
  end

  def read(database) do
    files = list_files(database)
    Enum.map(files, &(tuple_from_filesystem(&1, database)))
      |> Enum.into(%{})
  end

  defp list_files(database) do
    case :file.list_dir(database) do
      {:ok, files} -> files
      {:error, _} -> []
    end
  end

  defp tuple_from_filesystem(key, database) do
    {:ok, contents} = File.read(file_name(database, key))
    {"#{key}", :erlang.binary_to_term(contents)}
  end

  defp file_name(database, key) do
    Path.join(database, to_string(key))
  end
end
