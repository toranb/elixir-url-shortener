defmodule ExampleWeb.UrlController do
  use ExampleWeb, :controller

  def show(conn, %{"id" => id}) do
    url = EX.Worker.get(:worker, "#{id}")
    render(conn, "show.json", %{id: id, url: url})
  end

  def create(conn, %{"link" => %{"url" => url}}) do
    id = hmac(url)
    EX.Worker.put(:worker, id, url)
    render(conn, "show.json", %{id: id, url: url})
  end

  defp hmac(url) do
    :crypto.hmac(:sha256, "example", url)
      |> Base.encode16
      |> String.slice(0, 6)
  end
end
