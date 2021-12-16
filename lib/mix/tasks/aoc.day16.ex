defmodule Mix.Tasks.Aoc.Day16 do
  use Mix.Task

  alias Aoc2021.Day16

  def run(_args) do
    part1 = Day16.part1(Aoc2021.input_for("16"))
    IO.puts("Result for day16 part1: #{part1}")

    part2 = Day16.part2(Aoc2021.input_for("16"))
    IO.puts("Result for day16 part2: #{part2}")
  end
end
