defmodule ShortenerTest do
  use ExUnit.Case, async: true

  setup do
    EX.Shortener.new()
  end

  test "create will add key/value given url and hash", state do
    assert EX.Shortener.get_url(state, "x") === :undefined

    new_state = EX.Shortener.create_short_url(state, "x", "google.com")

    assert EX.Shortener.get_url(new_state, "x") === "google.com"
  end
end
