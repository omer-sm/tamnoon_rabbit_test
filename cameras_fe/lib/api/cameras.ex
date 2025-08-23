defmodule CamerasFe.Api.Cameras do
  import CamerasFe.Api.Config

  def get_cameras do
    case Req.get("#{backend()}/cameras") do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body}

      {:error, reason} ->
        {:error, reason}

      other ->
        {:error, other}
    end
  end
end
