defmodule EX.SupervisorTest do
  use ExUnit.Case, async: true

  setup do
    start_supervised!(EX.Supervisor)
    :ok
  end

  test "a new child process will restart as needed" do
    [{_, pid, _, _}] = Supervisor.which_children(EX.Supervisor)

    assert EX.Worker.get(pid, "x") === :undefined
    GenServer.stop(pid, :normal)

    [{_, new_pid, _, _}] = Supervisor.which_children(EX.Supervisor)
    assert new_pid !== pid

    assert EX.Worker.get(new_pid, "x") === :undefined
  end
end
