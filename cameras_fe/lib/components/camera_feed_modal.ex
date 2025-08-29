defmodule CamerasFe.Components.CameraFeedModal do
  @behaviour Tamnoon.Component

  def heex() do
    ~S"""
    <div class="modal fade" id="camera-feed-modal" tabindex="-1"
     data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Viewing '<span>@selected_camera_name</span>'</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick=@close_feed_modal></button>
          </div>
          <div class="modal-body">
            <video id="camera-feed-video" src=@camera_feed_url width="320" height="240" autoplay loop>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick=@close_feed_modal>Close</button>
          </div>
        </div>
      </div>
    </div>


    """
  end
end
