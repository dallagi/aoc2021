defmodule Aoc2021.Day10 do
  @delimiters %{"(" => ")", "{" => "}", "<" => ">", "[" => "]"}
  @opening_delimiters ~w"( [ { <"
  @closing_delimiters ~w") ] } >"

  def part1(input) do
    input
    |> parse
    |> Enum.map(&line_syntax_score/1)
    |> Enum.sum()
  end

  def part2(input) do
    nil
  end

  def line_syntax_score(line, open_delimiters \\ []) do
    case line do
      [] ->
        0

      [delimiter | rest] when delimiter in @opening_delimiters ->
        line_syntax_score(rest, [delimiter | open_delimiters])

      [delimiter | rest] when delimiter in @closing_delimiters ->
        if Enum.empty?(open_delimiters) or delimiter != @delimiters[hd(open_delimiters)] do
          syntax_score_for(delimiter)
        else
          line_syntax_score(rest, tl(open_delimiters))
        end
    end
  end

  defp syntax_score_for(")"), do: 3
  defp syntax_score_for("]"), do: 57
  defp syntax_score_for("}"), do: 1197
  defp syntax_score_for(">"), do: 25137

  defp parse(input) do
    input |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, "", trim: true))
  end
end
