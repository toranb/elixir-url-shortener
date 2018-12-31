defmodule ExampleWeb.AuthenticatorTest do
  use ExampleWeb.ConnCase, async: false

  test "login will authenticate the user and redirect unauthenticated requests", %{conn: conn} do
    id = "055577"
    url = "google.com"
    data = %{username: "toranb", password: "abc123"}
    toran = %{"id" => "01D3CC", "username" => "toranb"}
    google = %{"id" => id, "url" => url}

    post_result = post(conn, Routes.url_path(conn, :create, %{link: %{url: url}}))
    assert html_response(post_result, 302) =~ "redirected"

    get_result = get(conn, Routes.url_path(conn, :show, id))
    assert html_response(get_result, 302) =~ "redirected"

    result = post(conn, Routes.user_path(conn, :create, %{user: data}))
    assert json_response(result, 200) == toran
    authenticated = post(result, Routes.session_path(conn, :create, data))
    assert html_response(authenticated, 302) =~ "redirected"

    post_result = post(authenticated, Routes.url_path(conn, :create, %{link: %{url: url}}))
    assert json_response(post_result, 200) == google

    get_result = get(authenticated, Routes.url_path(conn, :show, id))
    assert json_response(get_result, 200) == google
  end
end
