defmodule Day23Memo do
  use Agent

  def start_link(), do: Agent.start_link(fn -> %{} end, name: __MODULE__)
  def set(key, value), do: Agent.update(__MODULE__, &Map.put(&1, key, value))
  def get(key), do: Agent.get(__MODULE__, &Map.get(&1, key))
end

defmodule Aoc2021.Day23 do
  @destination_room %{"A" => 2, "B" => 4, "C" => 6, "D" => 8}
  @hallway_size 11
  @reachable_hallway 0..(@hallway_size - 1)
                     |> Enum.to_list()
                     |> Kernel.--(Map.values(@destination_room))

  def part1(input) do
    Day23Memo.start_link()

    {res, steps} =
      input
      |> parse()
      |> build_map()
      |> least_energy_to_organize()
      |> IO.inspect()

    for {cost, map} <- steps do
      IO.puts("Cost: #{res - cost}")
      IO.puts("------")
      print(map, 2)
    end

    res
  end

  def part2(input) do
    nil
  end

  def least_energy_to_organize(%{hallway: _hallway, rooms: rooms} = map, steps \\ []) do
    cond do
      res = Day23Memo.get(map) ->
        res

      organized?(rooms) ->
        {0, []}

      true ->
        map
        |> all_possible_moves()
        |> Enum.map(fn
          {cost, new_map} ->
            case least_energy_to_organize(new_map, steps) do
              {new_cost, steps} -> {cost + new_cost, [{cost + new_cost, new_map} | steps]}
              nil -> nil
            end
        end)
        |> Enum.reject(&(&1 == nil))
        |> Enum.min_by(fn {cost, _steps} -> cost end, fn -> nil end)
    end
    |> tap(fn res -> Day23Memo.set(map, res) end)
  end

  def all_possible_moves(map) do
    case moves_from_hallway(map) do
      [] -> moves_from_rooms(map)
      moves -> moves
    end
  end

  defp moves_from_hallway(%{hallway: hallway, rooms: rooms}) do
    for {position, amphipod} <- hallway do
      destination_room_position = @destination_room[amphipod]
      destination_room = rooms[destination_room_position]

      rest_of_hallway = Map.delete(hallway, position)

      if destination_room_position in reachable_positions_from(rest_of_hallway, position) do
        case destination_room do
          [] ->
            {(2 + abs(position - destination_room_position)) * step_cost(amphipod),
             %{
               hallway: Map.delete(hallway, position),
               rooms: Map.put(rooms, destination_room_position, [amphipod])
             }}

          [^amphipod] ->
            {(1 + abs(position - destination_room_position)) * step_cost(amphipod),
             %{
               hallway: Map.delete(hallway, position),
               rooms: Map.put(rooms, destination_room_position, [amphipod, amphipod])
             }}

          _ ->
            nil
        end
      end
    end
    |> Enum.reject(&(&1 == nil))
  end

  defp moves_from_rooms(%{hallway: hallway, rooms: rooms} = _map) do
    for {room_position, amphipods_in_room} <- rooms do
      case amphipods_in_room do
        [amphipod, amphipod] when room_position == :erlang.map_get(amphipod, @destination_room) ->
          []

        [amphipod] when room_position == :erlang.map_get(amphipod, @destination_room) ->
          []

        [amphipod | rest] ->
          reachable_positions = reachable_positions_from(hallway, room_position)

          destination_room_position = @destination_room[amphipod]
          destination_room = rooms[destination_room_position]

          base_cost =
            case rest do
              [_] -> 1
              [] -> 2
            end

          can_move_directly_to_room? =
            destination_room_position in reachable_positions and
              (destination_room == [] or destination_room == [amphipod])

          if can_move_directly_to_room? do
            room_cost = if destination_room == [], do: 2, else: 1
            cost = base_cost + room_cost + abs(destination_room_position - room_position)

            new_rooms =
              rooms
              |> Map.put(room_position, rest)
              |> Map.update(destination_room_position, [], &[amphipod | &1])

            {cost * step_cost(amphipod), %{hallway: hallway, rooms: new_rooms}}
          else
            for position <- @reachable_hallway, position in reachable_positions do
              cost = base_cost + abs(position - room_position)
              new_rooms = Map.put(rooms, room_position, rest)
              new_hallway = Map.put(hallway, position, amphipod)

              {cost * step_cost(amphipod), %{hallway: new_hallway, rooms: new_rooms}}
            end
          end

        [] ->
          []
      end
    end
    |> List.flatten()
    |> Enum.reject(&(&1 == nil))
  end

  def reachable_positions_from(hallway, position) do
    occupied_hallway = Map.keys(hallway)

    starting_position =
      occupied_hallway
      |> Enum.filter(&(&1 <= position))
      |> Enum.max(fn -> -1 end)

    ending_position =
      occupied_hallway
      |> Enum.filter(&(&1 >= position))
      |> Enum.min(fn -> @hallway_size end)

    reachable_positions =
      for position <- 0..(@hallway_size - 1),
          position > starting_position and position < ending_position do
        position
      end

    # MapSet.new((starting_position + 1)..(ending_position-1))
    MapSet.new(reachable_positions)
  end

  defp organized?(%{2 => ["A", "A"], 4 => ["B", "B"], 6 => ["C", "C"], 8 => ["D", "D"]}), do: true
  defp organized?(_), do: false

  defp build_map(amphipods) do
    hallway = %{}

    rooms =
      for {room_position, amphipods_in_room} <- Enum.zip([2, 4, 6, 8], amphipods),
          into: %{},
          do: {room_position, amphipods_in_room}

    %{hallway: hallway, rooms: rooms}
  end

  defp step_cost("A"), do: 1
  defp step_cost("B"), do: 10
  defp step_cost("C"), do: 100
  defp step_cost("D"), do: 1000

  defp parse(input) do
    lines = String.split(input, "\n")
    first_amphipods = lines |> Enum.at(2) |> String.split("#", trim: true)
    second_amphipods = lines |> Enum.at(3) |> String.split("#", trim: true) |> Enum.drop(1)

    first_amphipods
    |> Enum.zip(second_amphipods)
    |> Enum.map(&Tuple.to_list/1)
  end

  defp print(%{hallway: hallway, rooms: rooms}, room_size) do
    IO.puts("#############")
    # HALLWAY
    IO.write("#")

    for i <- 0..(@hallway_size - 1) do
      IO.write(Map.get(hallway, i, "."))
    end

    IO.write("#\n")

    for depth <- 0..(room_size - 1) do
      IO.write("###")

      for pos <- [2, 4, 6, 8] do
        room = rooms[pos]

        case Enum.at(room, depth) do
          nil -> IO.write(".#")
          a -> IO.write(a <> "#")
        end
      end

      IO.write("##\n")
    end

    IO.puts("  #########  ")
  end
end
