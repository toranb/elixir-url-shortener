defmodule ExampleWeb.Router do
  use ExampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_secure_browser_headers
    plug ExampleWeb.Authenticator
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug ExampleWeb.Authenticator
  end

  scope "/", ExampleWeb do
    pipe_through(:browser)

    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/api", ExampleWeb do
    pipe_through(:api)
    resources "/urls", UrlController, only: [:show, :create]
    resources "/users", UserController, only: [:show, :create]
  end
end
