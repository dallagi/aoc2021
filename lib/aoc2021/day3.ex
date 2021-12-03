defmodule Aoc2021.Day3 do
  def part1(input) do
    digits_count =
      input
      |> parse()
      |> List.first()
      |> String.length()

    gamma_rate =
      input
      |> parse()
      |> most_frequent_digits()
      |> Enum.join("")
      |> String.to_integer(2)

    epsilon_rate = :math.pow(2, digits_count) - 1 - gamma_rate

    trunc(gamma_rate * epsilon_rate)
  end

  def part2(input) do
    input = parse(input)

    digits_count =
      input
      |> List.first()
      |> String.length()

    numbers =
      input
      |> Enum.map(fn number ->
        number
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
      end)

    oxygen_generator_rating =
      0..digits_count
      |> Enum.reduce_while(
        numbers,
        fn
          _idx, [number] ->
            {:halt, number}

          idx, numbers ->
            mfd = most_frequent_digits(Enum.map(numbers, &Enum.join(&1, "")))
            {:cont, Enum.filter(numbers, fn s -> Enum.at(s, idx) == Enum.at(mfd, idx) end)}
        end
      )
      |> Enum.join("")
      |> String.to_integer(2)

    co2_scrubber_rating =
      0..digits_count
      |> Enum.reduce_while(
        numbers,
        fn
          _idx, [number] ->
            {:halt, number}

          idx, numbers ->
            mfd = most_frequent_digits(Enum.map(numbers, &Enum.join(&1, ""))) |> Enum.map(&(1 - &1))
            {:cont, Enum.filter(numbers, fn s -> Enum.at(s, idx) == Enum.at(mfd, idx) end)}
        end
      )
      |> Enum.join("")
      |> String.to_integer(2)

      oxygen_generator_rating * co2_scrubber_rating
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

  defp most_frequent_digits(binaries) do
    input_len = Enum.count(binaries)

    binaries
    |> group_digits()
    |> Enum.map(&Tuple.sum/1)
    |> Enum.map(fn ones_count -> if ones_count >= input_len / 2, do: 1, else: 0 end)
  end
end
