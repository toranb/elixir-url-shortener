defmodule CacheTest do
  use ExUnit.Case, async: true

  test "all returns state and put updates it" do
    {:ok, _} = GenServer.start_link(EX.Cache, :ok)

    assert EX.Cache.all(:cache) === %{}

    EX.Cache.put(:cache, "x", "google.com")

    assert EX.Cache.all(:cache) === %{"x" => "google.com"}
  end
end
