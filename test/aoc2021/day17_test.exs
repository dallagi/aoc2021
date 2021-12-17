defmodule Aoc2021.Day17Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day17

  @example_input "target area: x=20..30, y=-10..-5"

  test "solves part1 for provided example" do
    assert 45 == Day17.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Day17.part2(@example_input)
  end

  test "determines trajectory of probe" do
    assert [{7, 2}, {13, 3}, {18, 3}, {22, 2}] == first_n_positions({7, 2}, 4)
    assert [{9, 0}, {17, -1}, {24, -3}, {30, -6}] == first_n_positions({9, 0}, 4)
    assert [{-9, 0}, {-17, -1}, {-24, -3}, {-30, -6}] == first_n_positions({-9, 0}, 4)
    assert [{0, 2}, {0, 3}, {0, 3}, {0, 2}, {0, 0}, {0, -3}] == first_n_positions({0, 2}, 6)
  end

  test "determines whether a target was surpassed" do
    assert Day17.surpassed_target?({10, 10}, {7..9, 7..9})
    assert Day17.surpassed_target?({1, 1}, {7..9, 7..9})

    refute Day17.surpassed_target?({1, 10}, {7..9, 7..9})
    refute Day17.surpassed_target?({-1, -1}, {-7..-9, -7..-9})
  end

  test "determines highest y when target is hit" do
    target = Day17.parse(@example_input)
    assert 3 == Day17.highest_y_if_hits({7, 2}, target)
  end

  defp first_n_positions(initial_velocity, n) do
    initial_velocity
    |> Day17.trajectory()
    |> Enum.take(n)
    |> Enum.map(fn {pos, _vel} -> pos end)
  end
end
