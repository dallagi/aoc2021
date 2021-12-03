defmodule Aoc2021.Day3 do
  def part1(input) do
    digits_count =
      input
      |> parse()
      |> List.first()
      |> String.length()

    input_len = input
      |> parse()
      |> Enum.count()

    gamma_rate =
      input
      |> parse()
      |> group_digits()
      |> Enum.map(&Tuple.sum/1)
      |> Enum.map(fn ones_count -> if ones_count > input_len / 2, do: 1, else: 0 end)
      |> Enum.join("")
      |> String.to_integer(2)

    epsilon_rate = :math.pow(2, digits_count) - 1 - gamma_rate

    trunc(gamma_rate * epsilon_rate)
  end

  def part2(input) do
    nil
  end

  defp parse(input) do
    input
    |> String.split()
  end

  defp group_digits(binary_nums) do
    binary_nums
    |> Enum.map(fn number ->
      number
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
  end
end
