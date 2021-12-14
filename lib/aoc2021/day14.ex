defmodule Aoc2021.Day14 do
  def part1(input) do
    [template, letters_count, insertions] = parse(input)
    {_, letters_count} = steps(template, letters_count, insertions, 10)

    {min, max} = letters_count |> Map.values() |> Enum.min_max()
    max - min
  end

  def part2(input) do
    [template, letters_count, insertions] = parse(input)
    {_, letters_count} = steps(template, letters_count, insertions, 40)

    {min, max} = letters_count |> Map.values() |> Enum.min_max()
    max - min
  end

  defp steps(template, letters_count, _, 0) do
    {template, letters_count}
  end

  defp steps(template, letters_count, insertions, remaining_steps) do
    {template, letters_count} = step(template, letters_count, insertions)

    steps(template, letters_count, insertions, remaining_steps - 1)
  end

  defp step(pairs, letters_count, insertions) do
    pairs
    |> Enum.reduce(
      {%{}, letters_count},
      fn {[p1, p2] = pair, pair_count}, {pairs_acc, letters_count_acc} ->
        [insertion] = Map.fetch!(insertions, pair)

        new_pairs =
          pairs_acc
          |> Map.update([p1, insertion], pair_count, fn count -> count + pair_count end)
          |> Map.update([insertion, p2], pair_count, fn count -> count + pair_count end)

        new_letters_count =
          Map.update(letters_count_acc, insertion, pair_count, fn count -> count + pair_count end)

        {new_pairs, new_letters_count}
      end
    )
  end

  defp parse(input) do
    [template_raw, insertions_raw] = String.split(input, "\n\n", trim: true)

    template =
      template_raw |> to_charlist |> Enum.chunk_every(2, 1, :discard) |> Enum.frequencies()

    letters_count = template_raw |> to_charlist |> Enum.frequencies()

    insertions =
      for insertion <- String.split(insertions_raw, "\n", trim: true),
          [from, to] = String.split(insertion, " -> ", parts: 2),
          into: %{},
          do: {to_charlist(from), to_charlist(to)}

    [template, letters_count, insertions]
  end
end
