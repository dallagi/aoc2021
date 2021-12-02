defmodule Aoc2021.Day2 do
  defmodule Position do
    defstruct [:horizontal, :depth]

    def initial, do: %__MODULE__{horizontal: 0, depth: 0}

    def apply(position, "forward", amount), do: Map.update!(position, :horizontal, &(&1 + amount))
    def apply(position, "up", amount), do: Map.update!(position, :depth, &(&1 - amount))
    def apply(position, "down", amount), do: Map.update!(position, :depth, &(&1 + amount))

    def multiply(position), do: position.horizontal * position.depth
  end

  alias __MODULE__.Position

  def part1(input) do
    input
    |> parse
    |> Enum.reduce(
      Position.initial(),
      fn {command, amount}, position ->
        Position.apply(position, command, amount)
      end
    )
    |> Position.multiply()
  end

  def part2(input) do
    input
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [command, amount] -> {command, String.to_integer(amount)} end)
  end
end
