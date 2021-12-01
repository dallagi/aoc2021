defmodule Mix.Tasks.Aoc.Day1 do
  use Mix.Task

  alias Aoc2021.Day1

  def run(_args) do
    part1 = Day1.part1(Aoc2021.input_for("01"))
    IO.puts("Result for day1 part1: #{part1}")

    part2 = Day1.part2(Aoc2021.input_for("01"))
    IO.puts("Result for day1 part2: #{part2}")
  end
end
