defmodule CamerasFe.Methods.UiMethods do
  import Tamnoon.MethodManager
  alias Tamnoon.DOM

  defmethod :switch_category do
    unselect_action =
      DOM.Actions.SetAttribute.new!(%{
        target:
          DOM.Node.new!(%{
            selector_type: :id,
            selector_value: "category-btn-#{state[:selected_category]}"
          }),
        attribute: "class",
        value: CamerasFe.Components.Ui.CategoriesTab.get_style_class(false)
      })

    new_selected_category = String.capitalize(req["key"])

    select_action =
      DOM.Actions.SetAttribute.new!(%{
        target:
          DOM.Node.new!(%{
            selector_type: :id,
            selector_value: "category-btn-#{new_selected_category}"
          }),
        attribute: "class",
        value: CamerasFe.Components.Ui.CategoriesTab.get_style_class(true)
      })

    Tamnoon.MethodManager.trigger_method(:render_cameras, %{}, 50)

    {%{selected_category: new_selected_category}, [unselect_action, select_action]}
  end

  defmethod :render_cameras do
    filtered_cameras =
      state[:cameras]
      |> Enum.filter(
        &(state[:selected_category] == "All" || &1["category"] == state[:selected_category])
      )

    cameras_list_html =
      Tamnoon.Compiler.render_component(
        CamerasFe.Components.CamerasList.CamerasList,
        %{cameras: filtered_cameras},
        true
      )

    replace_list_action =
      DOM.Actions.ReplaceNode.new!(%{
        target:
          DOM.Node.new!(%{
            selector_type: :id,
            selector_value: "cameras-container"
          }),
        replacement:
          DOM.Node.new!(%{
            selector_type: :from_string,
            selector_value: cameras_list_html
          })
      })

    {%{}, [replace_list_action]}
  end

  defmethod :close_feed_modal do
    {%{camera_feed_url: nil}}
  end
end
