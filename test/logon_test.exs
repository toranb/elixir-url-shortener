defmodule Example.LogonTest do
  use ExUnit.Case, async: false

  setup do
    TestProject.Helpers.cleanup
  end

  test "get and put work" do
    {:ok, _} = GenServer.start_link(Example.UserCache, :ok)
    {:ok, _} = GenServer.start_link(Example.Logon, :ok)

    {key, value} = Example.Logon.put(:logon, "toranb", "abc123")
    assert key == "01D3CC"
    assert value == "toranb"

    assert Example.Logon.get(:logon, "01D3CC") === "toranb"
    assert Example.Logon.get_by_username_and_password(:logon, "toranb", "abc123") === "01D3CC"
    assert Example.Logon.get_by_username_and_password(:logon, "jarrod", "def456") === nil

    {key, value} = Example.Logon.put(:logon, "jarrod", "def456")
    assert key == "962EDC"
    assert value == "jarrod"

    assert Example.Logon.get(:logon, "01D3CC") === "toranb"
    assert Example.Logon.get(:logon, "962EDC") === "jarrod"

    assert Example.Logon.get_by_username_and_password(:logon, "toranb", "abc123") === "01D3CC"
    assert Example.Logon.get_by_username_and_password(:logon, "jarrod", "def456") === "962EDC"
    assert Example.Logon.get_by_username_and_password(:logon, "jarrod", "def457") === nil
  end
end
