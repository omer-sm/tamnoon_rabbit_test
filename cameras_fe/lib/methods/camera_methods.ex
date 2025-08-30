defmodule CamerasFe.Methods.CameraMethods do
  import Tamnoon.MethodManager

  defmethod :select_camera do
    camera_id = req["key"]
    camera = Enum.find(state[:cameras], &(&1["id"] == camera_id))
    camera_feed_url = "#{CamerasFe.Api.Config.backend()}/cameras/#{camera_id}/video"

    Tamnoon.Methods.sub(%{"channel" => "camera_alerts_#{camera_id}"}, %{})

    {%{
       String.to_atom("camera_#{camera_id}_has_alert") => false,
       selected_camera_name: camera["name"],
       selected_camera_id: camera_id,
       camera_feed_url: camera_feed_url
     }}
  end
end
