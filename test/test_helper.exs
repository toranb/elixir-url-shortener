ExUnit.start()

defmodule TestProject.Helpers do

  @urls "./database/url"
  @users "./database/users"

  def cleanup do
    case remove_database(@urls) do
      _ -> :ok
    end
    case remove_database(@users) do
      _ -> :ok
    end
  end

  defp remove_database(dir) do
    files =
      case :file.list_dir(dir) do
        {:ok, files} -> files
        {:error, _} -> []
      end

    for key <- files do
      :file.delete(file_name(dir, key))
    end

    :file.del_dir(dir)
  end

  defp file_name(database, key) do
    Path.join(database, to_string(key))
  end
end
