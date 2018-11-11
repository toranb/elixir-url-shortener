defmodule ExampleWeb.UserView do
  use ExampleWeb, :view

  def render("show.json", %{id: id, username: username}) do
    %{id: id, username: username}
  end
end
