defmodule Example.WorkerTest do
  use ExUnit.Case, async: false

  setup do
    TestProject.Helpers.cleanup
  end

  test "get and put work" do
    {:ok, _} = GenServer.start_link(Example.Cache, :ok)
    {:ok, _} = GenServer.start_link(Example.Worker, :ok)

    assert Example.Worker.get(:worker, "77B5F6") === :undefined
    assert Example.Worker.get(:worker, "D07248") === :undefined

    {key, value} = Example.Worker.put(:worker, "google.com")
    assert key == "77B5F6"
    assert value == "google.com"

    assert Example.Worker.get(:worker, "77B5F6") === "google.com"
    assert Example.Worker.get(:worker, "D07248") === :undefined

    {key, value} = Example.Worker.put(:worker, "amazon.com")
    assert key == "D07248"
    assert value == "amazon.com"

    assert Example.Worker.get(:worker, "77B5F6") === "google.com"
    assert Example.Worker.get(:worker, "D07248") === "amazon.com"
  end
end
