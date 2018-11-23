defmodule ExampleWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :example

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_example_key",
    signing_salt: "8ixXSdpw"

  plug ExampleWeb.Router
end
