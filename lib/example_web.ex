defmodule ExampleWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: ExampleWeb
      import Plug.Conn
      import ExampleWeb.Router.Helpers
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/example_web/templates",
                        namespace: ExampleWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ExampleWeb.Router.Helpers
      import ExampleWeb.ErrorHelpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
