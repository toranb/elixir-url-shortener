defmodule ExampleWeb.Authenticator do
  import Plug.Conn, only: [get_session: 2, assign: 3]

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
      id ->
        username = Example.User.get(:user, "#{id}")
        assign(conn, :current_user, %{id: id, username: username})
    end
  end
end
