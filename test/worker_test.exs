defmodule EX.WorkerTest do
  use ExUnit.Case, async: false

  setup do
    TestProject.Helpers.cleanup
  end

  test "get and put work" do
    {:ok, _} = GenServer.start_link(EX.Cache, :ok)
    {:ok, _} = GenServer.start_link(EX.Worker, :ok)

    assert EX.Worker.get(:worker, "x") === :undefined

    EX.Worker.put(:worker, "x", "google.com")

    assert EX.Worker.get(:worker, "x") === "google.com"
  end
end
