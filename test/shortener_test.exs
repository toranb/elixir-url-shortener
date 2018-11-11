defmodule ShortenerTest do
  use ExUnit.Case, async: false

  test "create will add key/value given url and hash" do
    state = %{}

    assert Example.Shortener.get_url(state, "055577") === :undefined

    {new_state, {key, value}} = Example.Shortener.create_short_url(state, "google.com")
    [{hash, url}] = Map.to_list(new_state)
    assert key == "055577"
    assert value == "google.com"
    assert key == hash
    assert value == url

    assert Example.Shortener.get_url(new_state, "055577") === "google.com"

    {final_state, {key, value}} = Example.Shortener.create_short_url(new_state, "amazon.com")
    [_, {hash, url}] = Map.to_list(final_state)
    assert key == "365733"
    assert value == "amazon.com"
    assert key == hash
    assert value == url

    assert Example.Shortener.get_url(final_state, "055577") === "google.com"
    assert Example.Shortener.get_url(final_state, "365733") === "amazon.com"
  end
end
