defmodule Mix.Tasks.Aoc.Day19 do
  use Mix.Task

  alias Aoc2021.Day19

  def run(_args) do
    part1 = Day19.part1(Aoc2021.input_for("19"))
    IO.puts("Result for day19 part1: #{part1}")

    part2 = Day19.part2(Aoc2021.input_for("19"))
    IO.puts("Result for day19 part2: #{part2}")
  end
end
