defmodule Aoc2021.Day14 do
  def part1(input) do
    [template, insertions] = parse(input)

    after_10_steps =
      template
      |> steps(insertions, 10)

    {min, max} =
      after_10_steps
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.min_max()

    max - min
  end

  def part2(input) do
    nil
  end

  defp steps(template, _, 0) do
    template
  end

  defp steps(template, insertions, remaining_steps) do
    steps(step(template, insertions), insertions, remaining_steps - 1)
  end

  defp step(template, insertions, result \\ [])

  defp step([letter], insertions, result) do
    Enum.reverse([letter | result])
  end

  defp step([p1, p2 | template], insertions, result) do
    [insertion] = insertions[[p1, p2]]
    step([p2 | template], insertions, [insertion, p1 | result])
  end

  defp parse(input) do
    [template, insertions_raw] = String.split(input, "\n\n", trim: true)

    insertions =
      for insertion <- String.split(insertions_raw, "\n", trim: true),
          [from, to] = String.split(insertion, " -> ", parts: 2),
          into: %{},
          do: {to_charlist(from), to_charlist(to)}

    [to_charlist(template), insertions]
  end
end
