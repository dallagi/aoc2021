defmodule Mix.Tasks.Aoc.Day23 do
  use Mix.Task

  alias Aoc2021.Day23

  def run(_args) do
    part1 = Day23.part1(Aoc2021.input_for("23"))
    IO.puts("Result for day23 part1: #{part1}")

    part2 = Day23.part2(Aoc2021.input_for("23"))
    IO.puts("Result for day23 part2: #{part2}")
  end
end
