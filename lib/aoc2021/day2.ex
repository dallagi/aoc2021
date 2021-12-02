defmodule Aoc2021.Day2 do
  defmodule Part1Position do
    defstruct [:horizontal, :depth]

    def initial, do: %__MODULE__{horizontal: 0, depth: 0}

    def apply(position, "up", amount), do: Map.update!(position, :depth, &(&1 - amount))
    def apply(position, "down", amount), do: Map.update!(position, :depth, &(&1 + amount))

    def apply(position, "forward", amount),
      do: Map.update!(position, :horizontal, &(&1 + amount))

    def multiply(position), do: position.horizontal * position.depth
  end

  defmodule Part2Position do
    defstruct [:horizontal, :depth, :aim]

    def initial, do: %__MODULE__{horizontal: 0, depth: 0, aim: 0}

    def apply(position, "up", amount), do: Map.update!(position, :aim, &(&1 - amount))
    def apply(position, "down", amount), do: Map.update!(position, :aim, &(&1 + amount))

    def apply(position, "forward", amount) do
      %{
        position
        | horizontal: position.horizontal + amount,
          depth: position.depth + position.aim * amount
      }
    end

    def multiply(position), do: position.horizontal * position.depth
  end

  alias __MODULE__.Part1Position
  alias __MODULE__.Part2Position

  def part1(input) do
    input
    |> parse
    |> Enum.reduce(
      Part1Position.initial(),
      fn {command, amount}, position ->
        Part1Position.apply(position, command, amount)
      end
    )
    |> Part1Position.multiply()
  end

  def part2(input) do
    input
    |> parse
    |> Enum.reduce(
      Part2Position.initial(),
      fn {command, amount}, position ->
        Part2Position.apply(position, command, amount)
      end
    )
    |> Part2Position.multiply()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [command, amount] -> {command, String.to_integer(amount)} end)
  end
end
