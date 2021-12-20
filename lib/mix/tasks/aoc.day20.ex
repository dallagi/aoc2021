defmodule Mix.Tasks.Aoc.Day20 do
  use Mix.Task

  alias Aoc2021.Day20

  def run(_args) do
    part1 = Day20.part1(Aoc2021.input_for("20"))
    IO.puts("Result for day20 part1: #{part1}")

    part2 = Day20.part2(Aoc2021.input_for("20"))
    IO.puts("Result for day20 part2: #{part2}")
  end
end
