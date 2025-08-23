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
        value: CamerasFe.Components.CategoriesTab.get_style_class(false)
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
        value: CamerasFe.Components.CategoriesTab.get_style_class(true)
      })

    {%{selected_category: new_selected_category}, [unselect_action, select_action]}
  end
end
