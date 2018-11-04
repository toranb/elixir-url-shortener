defmodule ExampleWeb.UrlControllerTest do
  use ExampleWeb.ConnCase

  test "GET and POST drive the url shortener", %{conn: conn} do
    id = "77B5F6"
    url = "google.com"
    # default_result = get(conn, url_path(conn, :show, id))
    # default = %{"id" => id, "url" => "undefined"}
    # assert json_response(default_result, 200) == default

    google = %{"id" => id, "url" => url}
    google_result = post(conn, url_path(conn, :create, %{link: %{url: url}}))
    assert json_response(google_result, 200) == google

    get_result = get(conn, url_path(conn, :show, id))
    assert json_response(get_result, 200) == google

    amazon = %{"id" => "D07248", "url" => "amazon.com"}
    post_result = post(conn, url_path(conn, :create, %{link: %{url: "amazon.com"}}))
    assert json_response(post_result, 200) == amazon

    get_result = get(conn, url_path(conn, :show, "D07248"))
    assert json_response(get_result, 200) == amazon
    get_result = get(conn, url_path(conn, :show, id))
    assert json_response(get_result, 200) == google
  end
end
