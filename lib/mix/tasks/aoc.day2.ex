defmodule Mix.Tasks.Aoc.Day2 do
  use Mix.Task

  alias Aoc2021.Day2

  def run(_args) do
    part1 = Day2.part1(Aoc2021.input_for("02"))
    IO.puts("Result for day2 part1: #{part1}")

    part2 = Day2.part2(Aoc2021.input_for("02"))
    IO.puts("Result for day2 part2: #{part2}")
  end
end
