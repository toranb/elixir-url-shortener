defmodule EX.WorkerTest do
  use ExUnit.Case, async: false

  setup do
    TestProject.Helpers.cleanup
  end

  test "get and put work" do
    {:ok, _} = GenServer.start_link(EX.Cache, :ok)
    {:ok, _} = GenServer.start_link(EX.Worker, :ok)

    assert EX.Worker.get(:worker, "77B5F6") === :undefined
    assert EX.Worker.get(:worker, "D07248") === :undefined

    {key, value} = EX.Worker.put(:worker, "google.com")
    assert key == "77B5F6"
    assert value == "google.com"

    assert EX.Worker.get(:worker, "77B5F6") === "google.com"
    assert EX.Worker.get(:worker, "D07248") === :undefined

    {key, value} = EX.Worker.put(:worker, "amazon.com")
    assert key == "D07248"
    assert value == "amazon.com"

    assert EX.Worker.get(:worker, "77B5F6") === "google.com"
    assert EX.Worker.get(:worker, "D07248") === "amazon.com"
  end
end
