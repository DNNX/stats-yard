defmodule StatsYard.TimestampWriterTest do
  use ExUnit.Case

  test "can write timestamp to a file" do
    assert :ok == StatsYard.TimestampWriter.write_timestamp("tstamp_write.test", :os.system_time(1000))
  end

end
