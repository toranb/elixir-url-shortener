defmodule Example.UserTest do
  use ExUnit.Case, async: false

  setup do
    TestProject.Helpers.cleanup
  end

  test "get and put work" do
    {:ok, _} = GenServer.start_link(Example.UserCache, :ok)
    {:ok, _} = GenServer.start_link(Example.User, :ok)

    {key, value} = Example.User.put(:user, "toranb", "abc123")
    assert key == "01D3CC"
    assert value == "toranb"

    assert Example.User.get(:user, "01D3CC") === "toranb"

    {key, value} = Example.User.put(:user, "jarrod", "def456")
    assert key == "962EDC"
    assert value == "jarrod"

    assert Example.User.get(:user, "01D3CC") === "toranb"
    assert Example.User.get(:user, "962EDC") === "jarrod"
  end
end
