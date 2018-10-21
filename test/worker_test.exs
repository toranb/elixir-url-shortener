defmodule EX.WorkerTest do
  use ExUnit.Case, async: true

  setup do
    pid = start_supervised!(EX.Worker)
    %{pid: pid}
  end

  test "get and put work", %{pid: pid} do
    assert EX.Worker.get(pid, "x") === :undefined

    EX.Worker.put(pid, "x", "google.com")

    assert EX.Worker.get(pid, "x") === "google.com"
  end
end
