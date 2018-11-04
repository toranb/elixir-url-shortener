defmodule ExampleWeb.UrlController do
  use ExampleWeb, :controller

  def show(conn, %{"id" => id}) do
    url = EX.Worker.get(:worker, "#{id}")
    render(conn, "show.json", %{id: id, url: url})
  end

  def create(conn, %{"link" => %{"url" => url}}) do
    {key, value} = EX.Worker.put(:worker, url)
    render(conn, "show.json", %{id: key, url: value})
  end
end
