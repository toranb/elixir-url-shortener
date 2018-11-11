defmodule Example.Shortener do
  def new(), do: %{}

  def get_url(state, hash) do
    Map.get(state, hash, :undefined)
  end

  def create_short_url(state, url) do
    hash = hmac(url)
    new_state = Map.put(state, hash, url)
    {new_state, {hash, url}}
  end

  defp hmac(url) do
    :crypto.hmac(:sha256, "type:link", url)
      |> Base.encode16
      |> String.slice(0, 6)
  end
end
