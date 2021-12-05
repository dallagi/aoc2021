defmodule Mix.Tasks.Aoc.Gen do
  use Mix.Task
  import Mix.Generator

  def run(args) do
    day = Enum.at(args, 0)

    create_file(Path.join(["lib", "aoc2021", "day#{day}.ex"]), solution_template(day: day))
    create_file(Path.join(["test", "aoc2021", "day#{day}_test.exs"]), test_template(day: day))
    create_file(Path.join(["lib", "mix", "tasks", "aoc.day#{day}.ex"]), task_template(day: day))
  end

  embed_template(:solution, """
  defmodule Aoc2021.Day<%= @day %> do
    def part1(input) do
      nil
    end

    def part2(input) do
      nil
    end
  end
  """)

  embed_template(:test, """
  defmodule Aoc2021.Day<%= @day %>Test do
    use ExUnit.Case, async: true

    @example_input ""

    test "solves part1 for provided example" do
      # assert nil == Aoc2021.Day<%= @day %>.part1(@example_input)
    end

    test "solves part2 for provided example" do
      # assert nil == Aoc2021.Day<%= @day %>.part2(@example_input)
    end
  end
  """)

  embed_template(:task, """
  defmodule Mix.Tasks.Aoc.Day<%= @day %> do
    use Mix.Task

    alias Aoc2021.Day<%= @day %>

    def run(_args) do
      part1 = Day<%= @day %>.part1(Aoc2021.input_for("<%= String.pad_leading(@day, 2, "0") %>"))
      IO.puts("Result for day<%= @day %> part1: \#{part1}")

      part2 = Day<%= @day %>.part2(Aoc2021.input_for("<%= String.pad_leading(@day, 2, "0") %>"))
      IO.puts("Result for day<%= @day %> part2: \#{part2}")
    end
  end
  """)
end
