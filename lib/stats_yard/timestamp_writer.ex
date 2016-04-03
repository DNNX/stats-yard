defmodule StatsYard.TimestampWriter do
  use GenServer

  ###
  ### Public API
  ###

  def write_timestamp(filename, timestamp) do
    GenServer.call(__MODULE__, {:write_timestamp, filename, timestamp})
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

  def handle_call({:write_timestamp, filename, timestamp}, _from, state) do
    result = File.write(filename, "#{timestamp}")
    {:reply, result, state}
  end
end
