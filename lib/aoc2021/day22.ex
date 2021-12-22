defmodule Aoc2021.Day22 do
  def part1(input) do
    cube = for x <- -50..50, y <- -50..50, z <- -50..50, into: %{}, do: {{x, y, z}, 0}

    cube =
      input
      |> parse
      |> Enum.filter(fn {_action, ranges} ->
        Enum.all?(ranges, fn rstart..rend -> rstart in -50..50 and rend in -50..50 end)
      end)
      |> Enum.reduce(
        cube,
        fn {action, [x_range, y_range, z_range]}, cube ->
          Map.map(cube, fn {{x, y, z}, state} ->
            if x in x_range and y in y_range and z in z_range,
              do: action,
              else: state
          end)
        end
      )

    cube
    |> Map.values()
    |> Enum.count(&(&1 == 1))
  end

  def part2(input) do
    nil
  end

  defp parse(input) do
    steps = String.split(input, "\n", trim: true)

    for step <- steps do
      [action_description, axes] = String.split(step, " ", trim: true)

      action =
        case action_description do
          "on" -> 1
          "off" -> 0
        end

      cube =
        for axis <- String.split(axes, ",", trim: true) do
          [_, range] = String.split(axis, "=", trim: true)
          [range_start, range_end] = String.split(range, "..", trim: true)
          String.to_integer(range_start)..String.to_integer(range_end)
        end

      {action, cube}
    end
  end
end
