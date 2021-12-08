defmodule Aoc2021.Day8 do
  def part1(input) do
    input
    |> parse
    |> Enum.map(fn {_patterns, output} ->
      output
      |> Enum.filter(&(String.length(&1) in [2, 3, 4, 7]))
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse
    |> Enum.map(fn {patterns, output} ->
      decoder = decode_patterns(patterns)
      decode = fn pattern -> decoder[MapSet.new(String.graphemes(pattern))] end

      output
      |> Enum.map(decode)
      |> Enum.join()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  def decode_patterns(patterns) do
    patterns_sets = Enum.map(patterns, &(&1 |> String.graphemes() |> MapSet.new()))
    by_length = Enum.group_by(patterns_sets, &MapSet.size/1)

    first_by_cardinality = fn card -> get_in(by_length, [card, Access.at(0)]) end

    g =
      Enum.find_value(by_length[5], fn pattern ->
        # The #5 pattern that has only 1 letter not included in #2, #3 and #4 patterns
        letters_to_exclude =
          first_by_cardinality.(2)
          |> MapSet.union(first_by_cardinality.(3))
          |> MapSet.union(first_by_cardinality.(4))

        difference = MapSet.difference(pattern, letters_to_exclude)

        if MapSet.size(difference) == 1,
          do: difference |> MapSet.to_list() |> List.first(),
          else: nil
      end)

    # letter not included in (#2 + #3 + #4 + {g})
    letters_to_exclude =
      first_by_cardinality.(2)
      |> MapSet.union(first_by_cardinality.(3))
      |> MapSet.union(first_by_cardinality.(4))
      |> MapSet.put(g)

    e =
      ~w(a b c d e f g)
      |> MapSet.new()
      |> MapSet.difference(letters_to_exclude)
      |> MapSet.to_list()
      |> List.first()

    # #5 pattern that includes 'e'
    two = Enum.find(by_length[5], &MapSet.member?(&1, e))

    # #5 pattern that is superset of #2
    three = Enum.find(by_length[5], &MapSet.subset?(first_by_cardinality.(2), &1))

    # #5 pattern that is not two or three
    five = Enum.find(by_length[5], &(&1 != two && &1 != three))

    # #6 pattern that does not include 'e'
    nine = Enum.find(by_length[6], &(!MapSet.member?(&1, e)))

    # #6 pattern that is not nine and includes #2
    zero = Enum.find(by_length[6], &(&1 != nine and MapSet.subset?(first_by_cardinality.(2), &1)))

    # remaining pattern
    six = Enum.find(by_length[6], &(&1 != nine and &1 != zero))

    %{
      first_by_cardinality.(2) => 1,
      first_by_cardinality.(3) => 7,
      first_by_cardinality.(4) => 4,
      first_by_cardinality.(7) => 8,
      two => 2,
      three => 3,
      five => 5,
      nine => 9,
      zero => 0,
      six => 6
    }
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [patterns, output] = String.split(line, " | ", parts: 2, trim: true)
      {String.split(patterns, " ", trim: true), String.split(output, " ", trim: true)}
    end)
  end
end
