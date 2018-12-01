defmodule Example.Links do
  import Ecto.Query, warn: false

  alias Example.Repo
  alias Example.Link

  def all do
    Repo.all(Link)
  end

  def get!(id), do: Repo.get!(Link, id)

  def get_by(attrs \\ %{}) do
    Repo.get_by(Link, attrs, log: false)
  end

  def create_link(attrs \\ %{}) do
    Link
    |> struct(attrs)
    |> Repo.insert()
  end
end
