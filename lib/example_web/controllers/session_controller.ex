defmodule ExampleWeb.SessionController do
  use ExampleWeb, :controller

  import Plug.Conn, only: [put_session: 3]

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"username" => username, "password" => password}) do
    case Example.User.get_by_username_and_password(:user, username, password) do
      nil ->
        render(conn, "new.html")
      id ->
        conn
          |> put_session(:user_id, id)
          |> redirect(to: Routes.user_path(conn, :show, "#{id}"))
    end
  end
end
