defmodule Mix.Tasks.Aoc.Day7 do
  use Mix.Task

  alias Aoc2021.Day7

  def run(_args) do
    part1 = Day7.part1(Aoc2021.input_for("07"))
    IO.puts("Result for day7 part1: #{part1}")

    part2 = Day7.part2(Aoc2021.input_for("07"))
    IO.puts("Result for day7 part2: #{part2}")
  end
end
