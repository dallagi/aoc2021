defmodule Mix.Tasks.Aoc.Day22 do
  use Mix.Task

  alias Aoc2021.Day22

  def run(_args) do
    part1 = Day22.part1(Aoc2021.input_for("22"))
    IO.puts("Result for day22 part1: #{part1}")

    part2 = Day22.part2(Aoc2021.input_for("22"))
    IO.puts("Result for day22 part2: #{part2}")
  end
end
