defmodule Example.FindUserTest do
  use ExampleWeb.DataCase, async: false

  test "find with username and password" do
    state = %{}
    id = "01D3CC"
    username = "toranb"
    password = "abc123"
    password_hash = Example.Password.hash(password)

    assert Example.FindUser.with_username_and_password(state, username, password) === nil

    new_state = Map.put(state, id, {username, password_hash})
    assert Example.FindUser.with_username_and_password(new_state, username, password) === id
    assert Example.FindUser.with_username_and_password(new_state, username, "abc12") === nil

    id_two = "962EDC"
    username_two = "jarrod"
    password_two = "def456"
    password_hash_two = Example.Password.hash(password_two)
    last_state = Map.put(new_state, id_two, {username_two, password_hash_two})
    assert Example.FindUser.with_username_and_password(last_state, username, password) === id
    assert Example.FindUser.with_username_and_password(last_state, username_two, password_two) === id_two
    assert Example.FindUser.with_username_and_password(last_state, username_two, "") === nil
    assert Example.FindUser.with_username_and_password(last_state, username, password_two) === nil
  end
end
