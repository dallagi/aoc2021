defmodule Mix.Tasks.Aoc.Day21 do
  use Mix.Task

  alias Aoc2021.Day21

  def run(_args) do
    part1 = Day21.part1(Aoc2021.input_for("21"))
    IO.puts("Result for day21 part1: #{part1}")

    part2 = Day21.part2(Aoc2021.input_for("21"))
    IO.puts("Result for day21 part2: #{part2}")
  end
end
