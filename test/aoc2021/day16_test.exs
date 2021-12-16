defmodule Aoc2021.Day16Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day16

  test "decodes literal value" do
    assert {{:literal, 6, 2021}, _} = "D2FE28" |> Base.decode16!() |> Day16.decode()
  end

  test "decodes operator with length type 0" do
    assert {{:operator, 1, 6, [{:literal, _, 10}, {:literal, _, 20}]}, _} =
             "38006F45291200" |> Base.decode16!() |> Day16.decode()
  end

  test "decodes operator with length type 1" do
    assert {{:operator, 7, 3, [{:literal, _, 1}, {:literal, _, 2}, {:literal, _, 3}]}} =
             "EE00D40C823060" |> Base.decode16!() |> Day16.decode()
  end
end
