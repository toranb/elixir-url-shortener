defmodule Example.Hash do
  def hmac(key, value) do
    :crypto.hmac(:sha256, key, value)
      |> Base.encode16
      |> String.slice(0, 6)
  end
end
