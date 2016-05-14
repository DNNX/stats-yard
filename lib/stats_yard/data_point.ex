defmodule StatsYard.DataPoint do
  @moduledoc """
  Define the structure and validation functions for incoming stats data points
  """

  require Logger

  @type t :: %__MODULE__{metric: String.t, value: number, entity: String.t}
  defstruct [:metric, :value, :entity]

  def validate(%__MODULE__{metric: metric, value: value, entity: entity})
    when is_binary(metric)
    and is_binary(entity)
    and is_number(value) do
      Logger.debug("valid stat: #{inspect(%__MODULE__{metric: metric,
        value: value, entity: entity})}")
      {:ok, %__MODULE__{metric: metric, value: value, entity: entity}}
  end

  def validate(val) do
    Logger.warn("invalid stat: #{inspect(val)}")
    {:invalid, val}
  end

end
