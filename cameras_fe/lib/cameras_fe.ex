defmodule CamerasFe do
  require Logger
  alias CamerasFe.Api

  def init! do
    cameras = case Api.Cameras.get_cameras() do
      {:ok, body} -> body
      {:error, data} -> raise("Failed to get cameras in initial state: #{inspect(data)}")
    end

    categories = get_categories(cameras)

    category_tabs =
      categories
      |> Enum.map_join(&(Tamnoon.Compiler.render_component(
        CamerasFe.Components.CategoriesTab,
        %{
          category_name: &1,
          is_selected: &1 == "All"
        },
        true
      )))

    %{
      cameras: cameras,
      categories: categories,
      selected_category: "All",
      category_tabs: category_tabs
    }
  end

  def get_categories(cameras) do
    cameras
    |> MapSet.new(&Map.get(&1, "category", "Uncategorized"))
    |> MapSet.to_list()
    |> Enum.concat(["All"])
    |> Enum.sort()
  end
end
