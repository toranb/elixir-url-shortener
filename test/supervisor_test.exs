defmodule EX.SupervisorTest do
  use ExUnit.Case, async: true

  setup do
    TestProject.Helpers.cleanup
  end

  test "a new child process will restart as needed" do
    {:ok, _} = GenServer.start_link(EX.Supervisor, :ok)

    [{_, pid, _, _}, _, _] = Supervisor.which_children(EX.Supervisor)

    original = EX.Worker.get(:worker, "x")
    GenServer.stop(pid, :normal)

    [{_, new_pid, _, _}, _, _] = Supervisor.which_children(EX.Supervisor)
    assert new_pid !== pid

    assert EX.Worker.get(:worker, "x") === original
  end
end
