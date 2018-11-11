defmodule UserCacheTest do
  use ExUnit.Case, async: false

  setup do
    TestProject.Helpers.cleanup
  end

  test "all returns state and put updates it" do
    {:ok, _} = GenServer.start_link(Example.UserCache, :ok)

    assert Example.UserCache.all(:user_cache) === %{}

    Example.UserCache.put(:user_cache, "x", {"abc", "def"})

    assert Example.UserCache.all(:user_cache) === %{'x' => {"abc", "def"}}
  end
end
