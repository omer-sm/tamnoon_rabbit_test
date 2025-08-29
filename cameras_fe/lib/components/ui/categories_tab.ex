defmodule CamerasFe.Components.Ui.CategoriesTab do
  @behaviour Tamnoon.Component

  def heex() do
    ~S"""
      <li class="nav-item">
        <a id="category-btn-<%= @category_name %>"
          class="<%= CamerasFe.Components.Ui.CategoriesTab.get_style_class(false) %>"
          href="#" onclick=@switch_category-<%= String.downcase(@category_name) %>
        ><%= @category_name %></a>
      </li>
    """
  end

  def get_style_class(is_selected), do:
    (if is_selected, do: "nav-link active", else: "nav-link")
end
