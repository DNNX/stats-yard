defmodule StatsYard.TimestampWriterTest do
  use ExUnit.Case, async: false

  setup context do
    if cd = context[:cd] do
      prev_cd = File.cwd!
      File.cd!(cd)
      on_exit fn ->
        if tempfile = context[:tempfile] do
          if File.exists?(tempfile) do
            File.rm!(tempfile)
          end
        end

        File.cd!(prev_cd)
      end
    end

    :ok
  end

  @tag cd: "test/fixtures"
  @tag tempfile: "tstamp_write.test"
  test "can write timestamp to a file", context do
    assert :ok == StatsYard.TimestampWriter.write_timestamp(context[:tempfile], :os.system_time(1000))
  end

end
