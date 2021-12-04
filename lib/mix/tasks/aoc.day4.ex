defmodule Mix.Tasks.Aoc.Day4 do
  use Mix.Task

  alias Aoc2021.Day4

  def run(_args) do
    part1 = Day4.part1(Aoc2021.input_for("04"))
    IO.puts("Result for day4 part1: #{part1}")

    part2 = Day4.part2(Aoc2021.input_for("04"))
    IO.puts("Result for day4 part2: #{part2}")
  end
end
