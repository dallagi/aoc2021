defmodule Mix.Tasks.Aoc.Day24 do
  use Mix.Task

  alias Aoc2021.Day24

  def run(_args) do
    part1 = Day24.part1(Aoc2021.input_for("24"))
    IO.puts("Result for day24 part1: #{inspect(part1)}")

    part2 = Day24.part2(Aoc2021.input_for("24"))
    IO.puts("Result for day24 part2: #{part2}")
  end
end
