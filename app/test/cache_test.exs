defmodule CacheTest do
  use ExampleWeb.DataCase, async: false

  test "all returns state and put updates it" do
    {:ok, _} = GenServer.start_link(Example.Cache, :ok)

    assert Example.Cache.all(:cache) === %{}

    Example.Cache.put(:cache, "x", "google.com")

    assert Example.Cache.all(:cache) === %{"x" => "google.com"}
  end
end
