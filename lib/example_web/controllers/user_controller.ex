defmodule ExampleWeb.UserController do
  use ExampleWeb, :controller

  def show(conn, %{"id" => id}) do
    username = Example.Logon.get(:logon, "#{id}")
    render(conn, "show.json", %{id: id, username: username})
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    {id, username} = Example.Logon.put(:logon, username, password)
    render(conn, "show.json", %{id: id, username: username})
  end
end
