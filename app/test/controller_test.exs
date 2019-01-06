defmodule ExampleWeb.UrlControllerTest do
  use ExampleWeb.ConnCase, async: false

  import Plug.Test, only: [init_test_session: 2]

  test "GET and POST drive the url shortener", %{conn: conn} do
    id = "055577"
    url = "google.com"
    id_two = "365733"
    user_id = "01D3CC"

    username = "toranb"
    data = %{username: username, password: "abc123"}
    post(conn, Routes.user_path(conn, :create, %{user: data}))

    conn = conn
      |> init_test_session(%{user_id: user_id})

    google = %{"id" => id, "url" => url}
    google_result = post(conn, Routes.url_path(conn, :create, %{link: %{url: url}}))
    assert json_response(google_result, 200) == google

    get_result = get(conn, Routes.url_path(conn, :show, id))
    assert json_response(get_result, 200) == google

    amazon = %{"id" => id_two, "url" => "amazon.com"}
    post_result = post(conn, Routes.url_path(conn, :create, %{link: %{url: "amazon.com"}}))
    assert json_response(post_result, 200) == amazon

    get_result = get(conn, Routes.url_path(conn, :show, id_two))
    assert json_response(get_result, 200) == amazon

    get_result = get(conn, Routes.url_path(conn, :show, id))
    assert json_response(get_result, 200) == google
  end
end
