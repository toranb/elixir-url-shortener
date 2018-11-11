defmodule Example.WorkerTest do
  use ExUnit.Case, async: false

  setup do
    TestProject.Helpers.cleanup
  end

  test "get and put work" do
    {:ok, _} = GenServer.start_link(Example.Cache, :ok)
    {:ok, _} = GenServer.start_link(Example.Worker, :ok)

    assert Example.Worker.get(:worker, "055577") === :undefined
    assert Example.Worker.get(:worker, "365733") === :undefined

    {key, value} = Example.Worker.put(:worker, "google.com")
    assert key == "055577"
    assert value == "google.com"

    assert Example.Worker.get(:worker, "055577") === "google.com"
    assert Example.Worker.get(:worker, "365733") === :undefined

    {key, value} = Example.Worker.put(:worker, "amazon.com")
    assert key == "365733"
    assert value == "amazon.com"

    assert Example.Worker.get(:worker, "055577") === "google.com"
    assert Example.Worker.get(:worker, "365733") === "amazon.com"
  end
end
