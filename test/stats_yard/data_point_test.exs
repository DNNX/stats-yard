defmodule StatsYard.DataPointTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureLog

  @valid_data_points [
    %StatsYard.DataPoint{metric: "testmetric", value: 123, entity: "testhost"}
    ]

  @invalid_data_points [
    %StatsYard.DataPoint{metric: :testmetric, value: 123, entity: "testhost"},
    %StatsYard.DataPoint{metric: "testmetric", value: "123", entity: "testhost"},
    %StatsYard.DataPoint{metric: "testmetric", value: 123, entity: :testhost}
    ]

  test "can validate valid data points" do
    for valid_data_point <- @valid_data_points do
      assert capture_log([level: :debug], fn ->
        assert {:ok, ^valid_data_point} = StatsYard.DataPoint.validate(valid_data_point)
      end) =~ "valid stat: #{inspect(valid_data_point)}"
    end
  end

  test "can invalidate invalid data points" do
    for invalid_data_point <- @invalid_data_points do
      assert capture_log([level: :info], fn ->
        assert {:invalid, ^invalid_data_point} = StatsYard.DataPoint.validate(invalid_data_point)
      end) =~ "invalid stat: #{inspect(invalid_data_point)}"
    end
  end

end
