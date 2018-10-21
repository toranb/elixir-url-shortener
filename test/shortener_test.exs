defmodule ShortenerTest do
  use ExUnit.Case, async: true

  setup do
    Shortener.new()
  end

  test "create will add key/value given url and hash", state do
    assert Shortener.get_url(state, "x") === :undefined

    new_state = Shortener.create_short_url(state, "x", "google.com")

    assert Shortener.get_url(new_state, "x") === "google.com"
  end
end
