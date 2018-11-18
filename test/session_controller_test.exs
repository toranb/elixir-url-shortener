defmodule ExampleWeb.SessionControllerTest do
  use ExampleWeb.ConnCase

  import Plug.Conn, only: [get_session: 2]

  @id "01D3CC"
  @username "toranb"
  @toran %{"id" => @id, "username" => @username}
  @data %{username: @username, password: "abc123"}
  @login_form "<form action=\"/login\" method=\"POST\">"

  test "create will put user id into session and redirect", %{conn: conn} do
    result = post(conn, user_path(conn, :create, %{user: @data}))
    assert json_response(result, 200) == @toran

    login = post(conn, session_path(conn, :create, @data))
    assert html_response(login, 302) =~ "redirected"
    for {"location", value} <- login.resp_headers, do: assert value == "/api/users/#{@id}"

    session_id = get_session(login, :user_id)
    assert session_id == @id
  end

  test "failed login redirects to login form and does not put user id into session", %{conn: conn} do
    credentials = %{username: @username, password: "x"}

    login = post(conn, session_path(conn, :create, credentials))
    assert html_response(login, 200) =~ @login_form

    session_id = get_session(login, :user_id)
    assert session_id == nil

    result = post(conn, user_path(conn, :create, %{user: @data}))
    assert json_response(result, 200) == @toran

    login = post(conn, session_path(conn, :create, credentials))
    assert html_response(login, 200) =~ @login_form

    session_id = get_session(login, :user_id)
    assert session_id == nil
  end

  test "new route will return the login form", %{conn: conn} do
    login = get(conn, session_path(conn, :new))
    assert html_response(login, 200) =~ @login_form
  end
end
