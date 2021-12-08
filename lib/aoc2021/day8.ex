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
    by_cardinality = Enum.group_by(patterns_sets, &MapSet.size/1)
    first_by_cardinality = fn card -> get_in(by_cardinality, [card, Access.at(0)]) end

    one = first_by_cardinality.(2)
    seven = first_by_cardinality.(3)
    four = first_by_cardinality.(4)
    eight = first_by_cardinality.(7)

    g =
      Enum.find_value(by_cardinality[5], fn pattern ->
        # The #5 pattern that has only 1 letter not included in one, four and seven
        to_exclude = one |> MapSet.union(four) |> MapSet.union(seven)
        difference = MapSet.difference(pattern, to_exclude)

        if MapSet.size(difference) == 1, do: difference |> MapSet.to_list() |> List.first()
      end)

    # letter not included in (one + seven + four + {g})
    not_e = one |> MapSet.union(seven) |> MapSet.union(four) |> MapSet.put(g)

    e =
      ~w(a b c d e f g)
      |> MapSet.new()
      |> MapSet.difference(not_e)
      |> MapSet.to_list()
      |> List.first()

    # #5 pattern that includes 'e'
    two = Enum.find(by_cardinality[5], &MapSet.member?(&1, e))

    # #5 pattern that is superset of one
    three = Enum.find(by_cardinality[5], &MapSet.subset?(one, &1))

    # #5 pattern that is not two or three
    five = Enum.find(by_cardinality[5], &(&1 != two && &1 != three))

    # #6 pattern that does not include 'e'
    nine = Enum.find(by_cardinality[6], &(!MapSet.member?(&1, e)))

    # #6 pattern that is not nine and includes one
    zero = Enum.find(by_cardinality[6], &(&1 != nine and MapSet.subset?(one, &1)))

    # remaining pattern
    six = Enum.find(by_cardinality[6], &(&1 != nine and &1 != zero))

    %{
      one => 1,
      seven => 7,
      four => 4,
      eight => 8,
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
