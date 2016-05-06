defmodule StatsYard do
  use Application

  def start(_type, _args) do
    start_tstamp_writer()
    start_main_ingest()
  end

  def start_tstamp_writer() do
    import Supervisor.Spec, warn: false

    children = [
      worker(StatsYard.TimestampWriter, [])
    ]

    opts = [strategy: :one_for_one, name: StatsYard.TstampWriterSupervisor]
    Supervisor.start_link(children, opts)
  end

  def start_main_ingest() do
    import Supervisor.Spec, warn: false

    children = [
      worker(BlockingQueue, [1000, [name: main_ingest_queue]]),
      worker(StatsYard.IngestConsumer, [main_ingest_queue, [name: main_ingest_consumer]])
    ]

    opts = [strategy: :rest_for_one, name: StatsYard.MainIngestSupervisor]
    Supervisor.start_link(children, opts)
  end

  def main_ingest_queue, do: :main_ingest_queue
  def main_ingest_consumer, do: :main_ingest_consumer

end
