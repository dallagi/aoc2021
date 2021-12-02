defmodule Aoc2021.Day2 do
  def part1(input) do
    input
    |> parse
    |> Enum.reduce(
      %{horizontal: 0, depth: 0},
      fn
        {"up", amount}, position -> %{position | depth: position.depth - amount}
        {"down", amount}, position -> %{position | depth: position.depth + amount}
        {"forward", amount}, position -> %{position | horizontal: position.horizontal + amount}
      end
    )
    |> then(fn position -> position.horizontal * position.depth end)
  end

  def part2(input) do
    input
    |> parse
    |> Enum.reduce(
      %{horizontal: 0, depth: 0, aim: 0},
      fn
        {"up", amount}, position ->
          %{position | aim: position.aim - amount}

        {"down", amount}, position ->
          %{position | aim: position.aim + amount}

        {"forward", amount}, position ->
          %{
            position
            | horizontal: position.horizontal + amount,
              depth: position.depth + position.aim * amount
          }
      end
    )
    |> then(fn position -> position.horizontal * position.depth end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [command, amount] -> {command, String.to_integer(amount)} end)
  end
end
