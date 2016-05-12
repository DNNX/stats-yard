defmodule StatsYard.IngestConsumer do
  use GenServer
  require Logger

  defp consume_data_points(ingest_queue) do
    for stat <- BlockingQueue.pop_stream(ingest_queue) do
      case StatsYard.DataPoint.validate(stat) do
        {:ok, val} -> val
        {:invalid, val} -> val
      end
    end
  end

  ###
  ### GenServer defs
  ###

  def start_link(ingest_queue, opts \\ []) do
    GenServer.start_link(__MODULE__, ingest_queue, opts)
  end

  def init(ingest_queue) do
    spawn_link fn ->
      consume_data_points(ingest_queue)
    end

    {:ok, ingest_queue}
  end

end
