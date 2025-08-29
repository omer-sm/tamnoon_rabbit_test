defmodule CamerasFe.Rabbit.Consumer do
  use GenServer
  require Logger
  alias AMQP.{Connection, Channel, Basic, Queue}

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    {:ok, conn} = Connection.open("amqp://guest:guest@localhost")
    {:ok, chan} = Channel.open(conn)

    queue_name = "camera_alerts_queue"

    {:ok, _} = Queue.declare(chan, queue_name, durable: true)

    :ok = Queue.bind(chan, queue_name, "camera_alerts", routing_key: "#")

    # 3. Start consuming
    {:ok, _consumer_tag} = Basic.consume(chan, queue_name)

    Logger.info("Listening for messages from #{queue_name}")

    {:ok, %{channel: chan}}
  end

  @impl true
  def handle_info({:basic_deliver, payload_string, meta}, %{channel: chan} = state) do
    Logger.info("Received message: #{payload_string}")

    payload = Jason.decode!(payload_string)

    Tamnoon.Methods.pub(
      %{
        "channel" => "all_alerts",
        "action" => %{
          "method" => "handle_new_alert",
          "alert_data" => Map.take(payload, ["cameraId", "category"])
        }
      },
      %{}
    )

    # Acknowledge message
    Basic.ack(chan, meta.delivery_tag)

    {:noreply, state}
  end

  @impl true
  def handle_info({:basic_consume_ok, %{consumer_tag: _tag}}, state) do
    {:noreply, state}
  end

  @impl true
  def handle_info({:basic_cancel, %{consumer_tag: _tag}}, state) do
    {:stop, :normal, state}
  end

  @impl true
  def handle_info({:basic_cancel_ok, %{consumer_tag: _tag}}, state) do
    {:noreply, state}
  end
end
