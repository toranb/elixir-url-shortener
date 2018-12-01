defmodule Example.User do
  use Ecto.Schema

  @primary_key {:id, :string, []}
  schema "users" do
    field :username, :string
    field :hash, :string

    timestamps()
  end
end
