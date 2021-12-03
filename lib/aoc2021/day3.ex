defmodule Aoc2021.Day3 do
  def part1(input) do
    numbers = parse(input)

    digits_count =
      numbers
      |> List.first()
      |> Enum.count()

    gamma_rate =
      numbers
      |> most_frequent_digits()
      |> to_int()

    epsilon_rate = :math.pow(2, digits_count) - 1 - gamma_rate

    trunc(gamma_rate * epsilon_rate)
  end

  def part2(input) do
    numbers = parse(input)

    oxygen_generator_rating =
      numbers
      |> filter_values(fn numbers, idx -> most_frequent_digits(numbers) |> Enum.at(idx) end)
      |> to_int()

    co2_scrubber_rating =
      numbers
      |> filter_values(fn numbers, idx ->
        most_frequent_digits(numbers) |> Enum.map(&(1 - &1)) |> Enum.at(idx)
      end)
      |> to_int()

    oxygen_generator_rating * co2_scrubber_rating
  end

  defp parse(input) do
    input
    |> String.split()
    |> Enum.map(fn number ->
      number
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp group_digits(binary_nums), do: Enum.zip(binary_nums)

  defp filter_values(numbers, target_digit_fun) do
    digits_count =
      numbers
      |> List.first()
      |> Enum.count()

    0..digits_count
    |> Enum.reduce_while(
      numbers,
      fn
        _idx, [number] ->
          {:halt, number}

        idx, numbers ->
          {:cont,
           Enum.filter(numbers, fn num -> Enum.at(num, idx) == target_digit_fun.(numbers, idx) end)}
      end
    )
  end

  defp most_frequent_digits(binaries) do
    input_len = Enum.count(binaries)

    binaries
    |> group_digits()
    |> Enum.map(&Tuple.sum/1)
    |> Enum.map(fn ones_count -> if ones_count >= input_len / 2, do: 1, else: 0 end)
  end

  defp to_int(binary_digits) do
    binary_digits
    |> Enum.join("")
    |> String.to_integer(2)
  end
end
