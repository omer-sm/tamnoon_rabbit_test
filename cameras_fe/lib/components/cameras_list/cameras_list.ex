defmodule CamerasFe.Components.CamerasList.CamerasList do
  @behaviour Tamnoon.Component

  def heex() do
    ~S"""
    <div id="cameras-container" class="d-flex justify-content-around flex-wrap w-100 mt-2 px-5">
      <%= for camera <- @cameras do %>
        <%= r.([CamerasFe.Components.CamerasList.CameraCard, %{camera: camera}]) %>
      <% end %>
    </div>
    """
  end
end
