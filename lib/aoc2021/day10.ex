defmodule Aoc2021.Day10 do
  @delimiters %{"(" => ")", "{" => "}", "<" => ">", "[" => "]"}
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
    nil
  end

  defp check_line(line, open_delimiters \\ []) do
    case line do
      [] ->
        :ok

      [delimiter | rest] when delimiter in @opening_delimiters ->
        check_line(rest, [delimiter | open_delimiters])

      [delimiter | rest] when delimiter in @closing_delimiters ->
        if Enum.empty?(open_delimiters) or delimiter != @delimiters[hd(open_delimiters)] do
          {:syntax_error, delimiter, open_delimiters}
        else
          check_line(rest, tl(open_delimiters))
        end
    end
  end

  defp syntax_score(:ok), do: 0
  defp syntax_score({:syntax_error, ")", _}), do: 3
  defp syntax_score({:syntax_error, "]", _}), do: 57
  defp syntax_score({:syntax_error, "}", _}), do: 1197
  defp syntax_score({:syntax_error, ">", _}), do: 25137

  defp parse(input) do
    input |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, "", trim: true))
  end
end
