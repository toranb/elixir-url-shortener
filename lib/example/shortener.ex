defmodule Example.Shortener do
  import Example.Hash, only: [hmac: 2]

  def get_url(state, hash) do
    Map.get(state, hash, :undefined)
  end

  def create_short_url(state, url) do
    hash = hmac("type:link", url)
    new_state = Map.put(state, hash, url)
    {new_state, {hash, url}}
  end
end
