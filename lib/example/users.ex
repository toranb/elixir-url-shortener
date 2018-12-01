defmodule Example.Users do
  import Ecto.Query, warn: false

  alias Example.Repo
  alias Example.User

  def all do
    Repo.all(User)
  end

  def get!(id), do: Repo.get!(User, id)

  def get_by(attrs \\ %{}) do
    Repo.get_by(User, attrs, log: false)
  end

  def create_user(attrs \\ %{}) do
    User
    |> struct(attrs)
    |> Repo.insert()
  end
end
