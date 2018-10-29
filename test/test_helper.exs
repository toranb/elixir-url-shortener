ExUnit.start()

defmodule TestProject.Helpers do

  @database "./database"

  def cleanup do
    case remove_database() do
      _ -> :ok
    end
  end

  defp remove_database do
    files =
      case :file.list_dir(@database) do
        {:ok, files} -> files
        {:error, _} -> []
      end

    for key <- files do
      :file.delete(file_name(@database, key))
    end

    :file.del_dir(@database)
  end

  defp file_name(database, key) do
    Path.join(database, to_string(key))
  end
end
