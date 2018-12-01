defmodule Example.Link do
  use Ecto.Schema

  schema "links" do
    field :hash, :string
    field :url, :string

    timestamps()
  end
end
