defmodule StatsYard.TimestampWriter do
  use GenServer

  @moduledoc """
  This module is entirely devoted to writing timestamps to files.
  """

  ###
  ### Public API
  ###

  @doc """
  Writes the given timestamp to the given filename.

  ## Examples

    iex> StatsYard.Timestampwriter.write_timestamp("/tmp/foo.time",
      :os.system_time(1000))
    :ok

  """

  @spec write_timestamp(String.t, pos_integer) :: atom
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
