defmodule CamerasFe.Components.CamerasList.CameraCard do
  @behaviour Tamnoon.Component

  def heex do
    ~S"""
      <div class="card m-1" style="min-width: 18rem;">
        <div class="card-body">
          <h5 class="card-title"><%= @camera["name"] %></h5>
          <h6 class="card-subtitle mb-2 text-body-secondary"><%= @camera["category"] %> / <%= @camera["id"] %></h6>
        </div>
        <div class="card-footer">
          <button class="btn btn-primary" onclick=@select_camera-<%= @camera["id"] %>
          data-bs-toggle="modal" data-bs-target="#camera-feed-modal"
          >View feed</button>
        </div>
      </div>
    """
  end
end
