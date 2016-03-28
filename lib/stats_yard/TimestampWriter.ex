defmodule StatsYard.TimestampWriter do
  use GenServer

  ###
  ### Public API
  ###

  def write_timestamp(filename, timestamp) do
    GenServer.cast(__MODULE__, {:write_timestamp, filename, timestamp})
  end

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  ###
  ### GenServer callbacks
  ###

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:write_timestamp, filename, timestamp}, state) do
    :ok = File.write(filename, "#{timestamp}")
    {:noreply, state}
  end
end
