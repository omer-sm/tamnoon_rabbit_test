defmodule CamerasFe.Methods.AlertMethods do
  import Tamnoon.MethodManager
  alias Tamnoon.DOM

  defmethod :handle_new_alert do
    do_handle_new_alert(req["alert_data"], state)
  end

  defp do_handle_new_alert(
         %{"cameraId" => camera_id, "message" => message, "timestamp" => timestamp},
         %{selected_camera_id: selected_camera_id}
       )
       when camera_id == selected_camera_id do
    add_text_action =
      DOM.Actions.AddChild.new!(%{
        parent:
          DOM.Node.new!(%{
            selector_type: :id,
            selector_value: "camera-notifs-text"
          }),
        child:
          DOM.Node.new!(%{
            selector_type: :from_string,
            selector_value: "<li class=\"notif-log\">[#{timestamp}] #{message}</li>"
          })
      })

    {%{}, [add_text_action]}
  end

  defp do_handle_new_alert(
         %{"cameraId" => camera_id},
         %{selected_camera_id: selected_camera_id} = state
  ) when camera_id != selected_camera_id do
    unless Map.get(state, String.to_atom("camera_#{camera_id}_has_alert"), false) do
      {%{String.to_atom("camera_#{camera_id}_has_alert") => true}}
    else
      {}
    end
  end

  defp do_handle_new_alert(_alert_data, _state), do: {}
end
