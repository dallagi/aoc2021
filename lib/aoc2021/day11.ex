defmodule Aoc2021.Day11 do
  def part1(input) do
    input
    |> parse()
    |> count_flashes(100)
  end

  def part2(input) do
    input
    |> parse()
    |> first_synchronized_step()
  end

  defp count_flashes(octopuses, steps, flashes_so_far \\ 0)
  defp count_flashes(_octopuses, 0, flashes_so_far), do: flashes_so_far

  defp count_flashes(octopuses, steps, flashes_so_far) do
    new_octopuses = step(octopuses)
    flashes = new_octopuses |> Map.values() |> Enum.count(&(&1 == 0))

    count_flashes(new_octopuses, steps - 1, flashes_so_far + flashes)
  end

  defp first_synchronized_step(octopuses, step \\ 1) do
    new_octopuses = step(octopuses)
    all_flashing? = new_octopuses |> Map.values() |> Enum.all?(&(&1 == 0))

    if all_flashing?, do: step, else: first_synchronized_step(new_octopuses, step + 1)
  end

  defp step(octopuses) do
    octopuses
    |> Map.map(fn {_pos, energy} -> energy + 1 end)
    |> propagate_flashes()
  end

  defp propagate_flashes(octopuses) do
    to_flash =
      octopuses |> Map.filter(fn {_pos, energy} -> energy > 9 end) |> Map.keys() |> MapSet.new()

    close_to_flashing = neighbors(to_flash) |> Enum.frequencies()

    new_octopuses =
      Map.map(octopuses, fn
        {pos, energy} ->
          cond do
            energy == 0 -> 0
            pos in to_flash -> 0
            true -> energy + Map.get(close_to_flashing, pos, 0)
          end
      end)

    if Enum.empty?(to_flash), do: octopuses, else: propagate_flashes(new_octopuses)
  end

  defp neighbors(positions) do
    Enum.flat_map(positions, fn {x, y} ->
      for nx <- (x - 1)..(x + 1),
          ny <- (y - 1)..(y + 1),
          {x, y} != {nx, ny},
          do: {nx, ny}
    end)
  end

  defp print(octopuses) do
    width = octopuses |> Enum.map(fn {{x, _}, _} -> x end) |> Enum.max()
    height = octopuses |> Enum.map(fn {{_, y}, _} -> y end) |> Enum.max()

    for y <- 0..height,
        x <- 0..width do
      IO.write(octopuses[{x, y}])
      if x == width, do: IO.puts("")
    end
  end

  defp parse(input) do
    octopuses =
      for {row, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
          {elem, x} <- row |> String.split("", trim: true) |> Enum.with_index(),
          do: {{x, y}, String.to_integer(elem)}

    Enum.into(octopuses, %{})
  end
end
