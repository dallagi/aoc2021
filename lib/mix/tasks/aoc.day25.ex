defmodule Mix.Tasks.Aoc.Day25 do
  use Mix.Task

  alias Aoc2021.Day25

  def run(_args) do
    part1 = Day25.part1(Aoc2021.input_for("25"))
    IO.puts("Result for day25 part1: #{part1}")

    part2 = Day25.part2(Aoc2021.input_for("25"))
    IO.puts("Result for day25 part2: #{part2}")
  end
end
