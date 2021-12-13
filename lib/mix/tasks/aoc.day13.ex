defmodule Mix.Tasks.Aoc.Day13 do
  use Mix.Task

  alias Aoc2021.Day13

  def run(_args) do
    part1 = Day13.part1(Aoc2021.input_for("13"))
    IO.puts("Result for day13 part1: #{part1}")

    IO.puts("Result for day13 part2:")
    part2 = Day13.part2(Aoc2021.input_for("13"))
  end
end
