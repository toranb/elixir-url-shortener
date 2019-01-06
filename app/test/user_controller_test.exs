defmodule ExampleWeb.UserControllerTest do
  use ExampleWeb.ConnCase, async: false

  test "GET and POST fetch and create users", %{conn: conn} do
    id = "01D3CC"
    username = "toranb"
    password = "abc123"

    toran = %{"id" => id, "username" => username}
    result = post(conn, Routes.user_path(conn, :create, %{user: %{username: username, password: password}}))
    assert json_response(result, 200) == toran

    get_result = get(conn, Routes.user_path(conn, :show, id))
    assert json_response(get_result, 200) == toran
  end
end
