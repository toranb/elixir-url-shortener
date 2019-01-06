defmodule ExampleWeb.UrlController do
  use ExampleWeb, :controller

  plug :redirect_unauthorized

  def redirect_unauthorized(conn, _opts) do
    current_user = Map.get(conn.assigns, :current_user)
    if current_user != nil and current_user.username != nil do
      conn
    else
      conn
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
    end
  end

  def show(conn, %{"id" => id}) do
    url = Example.Worker.get(:worker, "#{id}")
    render(conn, "show.json", %{id: id, url: url})
  end

  def create(conn, %{"link" => %{"url" => url}}) do
    {key, value} = Example.Worker.put(:worker, url)
    render(conn, "show.json", %{id: key, url: value})
  end
end
