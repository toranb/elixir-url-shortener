defmodule Example.FindUser do
  alias Example.Password

  def with_username_and_password(users, username, password) do
    case Enum.filter(users, fn {_, {k, _}} -> k == username end) do
      [{id, {_username, hash}}] ->
        if Password.verify(password, hash) do
          id
        end
      [] ->
        nil
    end
  end

end
