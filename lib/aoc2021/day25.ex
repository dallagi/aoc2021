defmodule Aoc2021.Day25 do
  @direction %{">" => {1, 0}, "v" => {0, 1}}

  def part1(input) do
    map =
      input
      |> parse()
      |> steps_before_static_map()
  end

  def part2(input) do
    nil
  end

  def steps_before_static_map(map, steps_so_far \\ 1) do
    next_map = move(map)

    if map == next_map,
      do: steps_so_far,
      else: steps_before_static_map(next_map, steps_so_far + 1)
  end

  def move(map) do
    map
    |> move(">")
    |> move("v")
  end

  def move(%{size: map_size, map: map}, target_sea_cucumber) do
    new_map =
      for {position, sea_cucumber} <- map, into: %{} do
        if sea_cucumber == target_sea_cucumber do
          dest_position = destination(position, @direction[target_sea_cucumber], map_size)

          if Map.has_key?(map, dest_position) do
            {position, sea_cucumber}
          else
            {dest_position, sea_cucumber}
          end
        else
          {position, sea_cucumber}
        end
      end

    %{map: new_map, size: map_size}
  end

  def destination({x, y}, {delta_x, delta_y} = direction, {max_x, max_y} = _map_size) do
    dest_x = x + delta_x
    dest_x = if dest_x > max_x, do: 0, else: dest_x
    dest_y = y + delta_y
    dest_y = if dest_y > max_y, do: 0, else: dest_y

    {dest_x, dest_y}
  end

  def parse(input) do
    map =
      for {line, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
          {elem, x} <- line |> String.split("", trim: true) |> Enum.with_index(),
          elem != ".",
          into: %{} do
        {{x, y}, elem}
      end

    max_x = map |> Enum.map(fn {{x, _}, _} -> x end) |> Enum.max()
    max_y = map |> Enum.map(fn {{_, y}, _} -> y end) |> Enum.max()

    %{size: {max_x, max_y}, map: map}
  end

  def render(%{size: {max_x, max_y}, map: map}) do
    Enum.join(
      for y <- 0..max_y do
        Enum.join(for(x <- 0..max_x, do: Map.get(map, {x, y}, ".")), "")
      end,
      "\n"
    )
  end
end
