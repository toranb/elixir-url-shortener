defmodule UserCacheTest do
  use ExampleWeb.DataCase, async: false

  test "all returns state and put updates it" do
    {:ok, _} = GenServer.start_link(Example.UserCache, :ok)

    assert Example.UserCache.all(:user_cache) === %{}

    Example.UserCache.put(:user_cache, "x", {"abc", "def"})

    assert Example.UserCache.all(:user_cache) === %{"x" => {"abc", "def"}}
  end
end
