defmodule ExampleWeb.UrlView do
  use ExampleWeb, :view

  def render("show.json", %{id: id, url: url}) do
    %{id: id, url: url}
  end
end
