defmodule CamerasFe.Methods.AlertMethods do
  import Tamnoon.MethodManager

  defmethod :handle_new_alert do
    do_handle_new_alert(req["alert_data"], state)
  end

  defp do_handle_new_alert(
         %{"category" => category, "cameraId" => camera_id},
         %{selected_category: selected_category} = state
       )
       when category == selected_category or selected_category == "All" do
    unless Map.get(state, String.to_atom("camera_#{camera_id}_has_alert"), false) do
      {%{String.to_atom("camera_#{camera_id}_has_alert") => true}}
    else
      {}
    end
  end

  defp do_handle_new_alert(_alert_data, _state), do: {}
end
