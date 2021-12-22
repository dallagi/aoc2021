defmodule Aoc2021.Day22 do
  def part1(input) do
    input
    |> parse
    |> Enum.filter(fn {_action, ranges} ->
      Enum.all?(ranges, fn from..to -> from in -50..50 and to in -50..50 end)
    end)
    |> cubes_on_after_init_procedure()
  end

  def part2(input) do
    input
    |> parse
    |> cubes_on_after_init_procedure()
  end

  def cubes_on_after_init_procedure(steps) do
    {cubes_on_count, _} =
      for {action, cube} <- Enum.reverse(steps),
          reduce: {0, []} do
        {cubes_on, previous_cubes} ->
          case action do
            0 ->
              {cubes_on, [cube | previous_cubes]}

            1 ->
              new_cubes =
                Enum.reduce(
                  previous_cubes,
                  [cube],
                  fn prev_cube, cubes ->
                    Enum.flat_map(cubes, &subtract(&1, prev_cube))
                  end
                )

              new_cubes_on = new_cubes |> Enum.map(&volume/1) |> Enum.sum()
              {new_cubes_on + cubes_on, [cube | previous_cubes]}
          end
      end

    cubes_on_count
  end

  def volume(axes) do
    axes
    |> Enum.map(&Range.size/1)
    |> Enum.reduce(&Kernel.*/2)
  end

  def subtract(cube, other_cube) do
    intersection =
      for {cube_range, other_range} <- Enum.zip(cube, other_cube),
          do: range_intersection(cube_range, other_range)

    if nil in intersection do
      [cube]
    else
      [cube_x, cube_y, cube_z] = cube
      [int_x, int_y, int_z] = intersection

      for xr <- ranges(cube_x, int_x),
          xr != nil,
          yr <- ranges(cube_y, int_y),
          yr != nil,
          zr <- ranges(cube_z, int_z),
          zr != nil,
          cube = [xr, yr, zr],
          cube != intersection,
          do: cube
    end
  end

  def ranges(r_from..r_to, i_from..i_to) do
    [
      if(r_from < i_from, do: r_from..(i_from - 1), else: nil),
      i_from..i_to,
      if(i_to < r_to, do: (i_to + 1)..r_to, else: nil)
    ]
  end

  def range_intersection(from1..to1 = r1, from2..to2 = r2) do
    if Range.disjoint?(r1, r2), do: nil, else: max(from1, from2)..min(to1, to2)
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
