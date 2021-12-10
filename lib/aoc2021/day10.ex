defmodule Aoc2021.Day10 do
  @opening_delimiters ~w"( [ { <"
  @closing_delimiters ~w") ] } >"

  def part1(input) do
    input
    |> parse
    |> Enum.map(&check_line/1)
    |> Enum.map(&syntax_score/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse
    |> Enum.map(&check_line/1)
    |> Enum.filter(&(elem(&1, 0) == :incomplete))
    |> Enum.map(&autocomplete_score/1)
    |> median()
  end

  defp check_line(line, open_delimiters \\ []) do
    case line do
      [] ->
        {:incomplete, open_delimiters}

      [delimiter | rest] when delimiter in @opening_delimiters ->
        check_line(rest, [delimiter | open_delimiters])

      [delimiter | rest] when delimiter in @closing_delimiters ->
        if Enum.empty?(open_delimiters) or delimiter != closing_delimiter(hd(open_delimiters)) do
          {:syntax_error, delimiter}
        else
          check_line(rest, tl(open_delimiters))
        end
    end
  end

  defp closing_delimiter("("), do: ")"
  defp closing_delimiter("{"), do: "}"
  defp closing_delimiter("["), do: "]"
  defp closing_delimiter("<"), do: ">"

  defp syntax_score({:syntax_error, ")"}), do: 3
  defp syntax_score({:syntax_error, "]"}), do: 57
  defp syntax_score({:syntax_error, "}"}), do: 1197
  defp syntax_score({:syntax_error, ">"}), do: 25137
  defp syntax_score(_), do: 0

  defp autocomplete_score({:incomplete, open_delimiters}) do
    value = %{"(" => 1, "[" => 2, "{" => 3, "<" => 4}

    Enum.reduce(open_delimiters, 0, fn delimiter, score ->
      score * 5 + value[delimiter]
    end)
  end

  defp autocomplete_score(_), do: 0

  defp median(enumerable) do
    idx = div(length(enumerable), 2)
    Enum.at(Enum.sort(enumerable), idx)
  end

  defp parse(input) do
    input |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, "", trim: true))
  end
end
