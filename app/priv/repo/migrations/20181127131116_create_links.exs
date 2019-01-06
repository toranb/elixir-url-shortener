defmodule Example.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :hash, :string, primary_key: true
      add :url, :string

      timestamps()
    end

    create unique_index(:links, [:url])
  end
end
