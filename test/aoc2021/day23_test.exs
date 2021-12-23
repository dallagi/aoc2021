defmodule Aoc2021.Day23Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day23

  @example_input """
  #############
  #...........#
  ###B#C#B#D###
    #A#D#C#A#
    #########
  """

  test "solves part1 for provided example" do
    assert 12521 == Day23.part1(@example_input) |> IO.inspect(pretty: true)
  end

  test "solves part2 for provided example" do
    # assert nil == Day23.part2(@example_input)
  end

  test "an already-organized map costs nothing to reorder" do
    organized_map = """
    #############
    #...........#
    ###A#B#C#D###
      #A#B#C#D#
      #########
    """

    assert 0 == Day23.part1(organized_map)
  end

  test "least energy to organize when only one step is necessary" do
    Day23Memo.start_link()

    map = %{
      hallway: %{1 => "A"},
      rooms: %{2 => ["A"], 4 => ["B", "B"], 6 => ["C", "C"], 8 => ["D", "D"]}
    }

    assert 2 == Day23.least_energy_to_organize(map)
  end

  test "least energy to organize when one swap is necessary" do
    Day23Memo.start_link()

    map = %{
      hallway: %{},
      rooms: %{2 => ["B", "A"], 4 => ["A", "B"], 6 => ["C", "C"], 8 => ["D", "D"]}
    }

    # TODO check result 
    assert 46 == Day23.least_energy_to_organize(map)
  end

  test "reachable_positions" do
    assert MapSet.new([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) ==
             Day23.reachable_positions_from(%{}, 2)

    assert MapSet.new([0, 1, 2, 3]) == Day23.reachable_positions_from(%{4 => "A"}, 2)
    assert MapSet.new([2, 3]) == Day23.reachable_positions_from(%{1 => "B", 4 => "A"}, 2)
    assert MapSet.new([0, 1, 2, 3, 4]) == Day23.reachable_positions_from(%{5 => "B", 7 => "D"}, 4)
    assert MapSet.new([]) == Day23.reachable_positions_from(%{2 => "A"}, 2)
    assert MapSet.new([]) == Day23.reachable_positions_from(%{5 => "D", 7 => "B"}, 7)
  end

  test "possible moves forces amphipod from hallway into their room when possible" do
    assert [{2, %{hallway: %{}, rooms: %{2 => ["A", "A"], 4 => ["B", "B"]}}}] ==
             Day23.all_possible_moves(%{
               hallway: %{1 => "A"},
               rooms: %{2 => ["A"], 4 => ["B", "B"]}
             })
  end

  test "cannot move amphipods already in destination place" do
    assert [] =
             Day23.all_possible_moves(%{
               hallway: %{},
               rooms: %{2 => ["A", "A"], 4 => ["B", "B"], 6 => ["C", "C"], 8 => ["D", "D"]}
             })
  end

  test "possible moves" do
    assert [] == Day23.all_possible_moves(%{hallway: %{1 => "A", 3 => "B"}, rooms: %{2 => ["C"]}})

    assert [
             {3, %{hallway: %{0 => "A"}, rooms: %{2 => ["B"], 4 => ["B", "A"]}}},
             {2, %{hallway: %{1 => "A"}, rooms: %{2 => ["B"], 4 => ["B", "A"]}}},
             {2, %{hallway: %{3 => "A"}, rooms: %{2 => ["B"], 4 => ["B", "A"]}}},
             {4, %{hallway: %{5 => "A"}, rooms: %{2 => ["B"], 4 => ["B", "A"]}}},
             {6, %{hallway: %{7 => "A"}, rooms: %{2 => ["B"], 4 => ["B", "A"]}}},
             {8, %{hallway: %{9 => "A"}, rooms: %{2 => ["B"], 4 => ["B", "A"]}}},
             {50, %{hallway: %{0 => "B"}, rooms: %{2 => ["A", "B"], 4 => ["A"]}}},
             {40, %{hallway: %{1 => "B"}, rooms: %{2 => ["A", "B"], 4 => ["A"]}}},
             {20, %{hallway: %{3 => "B"}, rooms: %{2 => ["A", "B"], 4 => ["A"]}}},
             {20, %{hallway: %{5 => "B"}, rooms: %{2 => ["A", "B"], 4 => ["A"]}}},
             {40, %{hallway: %{7 => "B"}, rooms: %{2 => ["A", "B"], 4 => ["A"]}}},
             {60, %{hallway: %{9 => "B"}, rooms: %{2 => ["A", "B"], 4 => ["A"]}}}
           ] =
             Day23.all_possible_moves(%{hallway: %{}, rooms: %{2 => ["A", "B"], 4 => ["B", "A"]}})
  end

  test "all possible moves - debugging" do
    assert [] ==
             Day23.all_possible_moves(%{
               hallway: %{5 => "B", 7 => "D"},
               rooms: %{4 => ["C", "D"], 6 => ["C"]}
             })
  end
end
