defmodule Aoc2021.Day17 do
  def part1(input) do
    target = parse(input)
    {initial_xs, initial_ys} = initial_starting_velocities(target)

    highest_ys =
      for x_vel <- initial_xs, y_vel <- initial_ys do
        initial_velocity = {x_vel, y_vel}
        highest_y_if_hits(initial_velocity, target)
      end

    highest_ys
    |> Enum.reject(&(&1 == nil))
    |> Enum.max()
  end

  def part2(input) do
    target = parse(input)
    {initial_xs, initial_ys} = initial_starting_velocities(target)

    highest_ys =
      for x_vel <- initial_xs, y_vel <- initial_ys do
        initial_velocity = {x_vel, y_vel}
        highest_y_if_hits(initial_velocity, target)
      end

    highest_ys
    |> Enum.reject(&(&1 == nil))
    |> Enum.count()
  end

  defp initial_starting_velocities({x_range, y_range} = _target) do
    initial_xs = Enum.to_list(0..Enum.min(x_range))
    initial_xs = initial_xs ++ (Enum.to_list(0..Enum.max(x_range)))

    max_abs_y = y_range |> Enum.map(&Kernel.abs/1) |> Enum.max
    initial_ys = Enum.to_list(0..max_abs_y)
    initial_ys = initial_ys ++ Enum.to_list(0..(-max_abs_y))

    {Enum.uniq(initial_xs), Enum.uniq(initial_ys)}
  end

  def highest_y_if_hits(initial_velocity, target) do
    Enum.reduce_while(
      trajectory(initial_velocity),
      {0, false},
      fn {position, _velocity}, {highest_y, hit_target?} ->
        if surpassed_target?(position, target) do
          res = if hit_target?, do: highest_y, else: nil
          {:halt, res}
        else
          {_, y} = position
          highest_y = max(highest_y, y)
          hit_target? = hit_target? || hit?(position, target)
          {:cont, {highest_y, hit_target?}}
        end
      end
    )
  end

  def surpassed_target?({x, y}, {x_range, y_range} = _target) do
    surpassed_x = abs(x) > x_range |> Enum.map(&Kernel.abs/1) |> Enum.max()
    surpassed_y = y < Enum.min(y_range)
    surpassed_x or surpassed_y
  end

  defp hit?({x, y}, {x_range, y_range}), do: x in x_range and y in y_range

  def trajectory({_, _} = position \\ {0, 0}, {_, _} = velocity) do
    Stream.unfold(
      {position, velocity},
      fn {{x_pos, y_pos}, {x_vel, y_vel}} ->
        new_position = {x_pos + x_vel, y_pos + y_vel}

        new_x_vel =
          cond do
            x_vel > 0 -> x_vel - 1
            x_vel < 0 -> x_vel + 1
            x_vel == 0 -> x_vel
          end

        new_y_vel = y_vel - 1
        new_velocity = {new_x_vel, new_y_vel}

        {{new_position, new_velocity}, {new_position, new_velocity}}
      end
    )
  end

  def parse(input) do
    regex =
      ~r/target area: x=(?<x_start>-?\d+)\.\.(?<x_end>-?\d+), y=(?<y_start>-?\d+)\.\.(?<y_end>-?\d+)/

    captures =
      regex
      |> Regex.named_captures(input)
      |> Map.map(fn {_, value} -> String.to_integer(value) end)

    {captures["x_start"]..captures["x_end"], captures["y_start"]..captures["y_end"]}
  end
end
