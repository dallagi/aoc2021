defmodule Aoc2021.Day16Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day16

  @example_input ""

  test "solves part1 for provided example" do
    # assert nil == Day16.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Day16.part2(@example_input)
  end

  test "decodes literal value" do
    assert {{:literal, 6, 2021}, _} = "D2FE28" |> Base.decode16!() |> Day16.decode()
  end

  test "decodes operator" do
    assert {{:operator, 1, 6, [{:literal, _, 10}, {:literal, _, 20}]}, _} =
             "38006F45291200" |> Base.decode16!() |> Day16.decode()
  end
end