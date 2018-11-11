defmodule ExampleWeb.UserController do
  use ExampleWeb, :controller

  def show(conn, %{"id" => id}) do
    username = Example.User.get(:user, "#{id}")
    render(conn, "show.json", %{id: id, username: username})
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    {id, username} = Example.User.put(:user, username, password)
    render(conn, "show.json", %{id: id, username: username})
  end
end
