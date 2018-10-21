defmodule Shortener do
  def new(), do: %{}

  def create_short_url(state, hash, url) do
    Map.put(state, hash, url)
  end

  def get_url(state, hash) do
    Map.get(state, hash, :undefined)
  end
end
