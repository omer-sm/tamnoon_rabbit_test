defmodule CamerasFe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Tamnoon, [[
        router: CamerasFe.Router,
        initial_state: &CamerasFe.init!/0,
        methods_modules: [CamerasFe.Methods.UiMethods]
      ]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CamerasFe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
