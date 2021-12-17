defmodule Aoc2021.Day17 do
  def part1(input) do
    target = parse(input)
    {initial_x_velocities, initial_y_velocities} = initial_starting_velocities(target)

    highest_ys =
      for x_vel <- initial_x_velocities,
        y_vel <- initial_y_velocities,
        do: highest_y_if_hits({x_vel, y_vel}, target)

    highest_ys
    |> Enum.reject(&(&1 == nil))
    |> Enum.max()
  end

  def part2(input) do
    target = parse(input)
    {initial_x_velocities, initial_y_velocities} = initial_starting_velocities(target)

    highest_ys =
      for x_vel <- initial_x_velocities,
        y_vel <- initial_y_velocities,
        do: highest_y_if_hits({x_vel, y_vel}, target)

    highest_ys
    |> Enum.reject(&(&1 == nil))
    |> Enum.count()
  end

  defp initial_starting_velocities({x_range, y_range} = _target) do
    initial_x_velocities = Enum.to_list(0..Enum.min(x_range)) ++ Enum.to_list(0..Enum.max(x_range))

    max_abs_y = y_range |> Enum.map(&Kernel.abs/1) |> Enum.max()
    initial_y_velocities = Enum.to_list(0..max_abs_y) ++ Enum.to_list(0..-max_abs_y)

    {Enum.uniq(initial_x_velocities), Enum.uniq(initial_y_velocities)}
  end

  def highest_y_if_hits(initial_velocity, target) do
    Enum.reduce_while(
      trajectory(initial_velocity),
      {0, false},
      fn position, {highest_y, hit_target?} ->
        if surpassed_target?(position, target) do
          res = if hit_target?, do: highest_y, else: nil
          {:halt, res}
        else
          {_x, y} = position
          highest_y = max(highest_y, y)
          hit_target? = hit_target? || hit?(position, target)
          {:cont, {highest_y, hit_target?}}
        end
      end
    )
  end

  def surpassed_target?({x, y}, {x_range, y_range} = _target) do
    surpassed_x? = abs(x) > x_range |> Enum.map(&Kernel.abs/1) |> Enum.max()
    surpassed_y? = y < Enum.min(y_range)
    surpassed_x? or surpassed_y?
  end

  defp hit?({x, y}, {x_range, y_range}), do: x in x_range and y in y_range

  def trajectory({_, _} = velocity) do
    initial_position = {0, 0}

    Stream.unfold(
      {initial_position, velocity},
      fn {{x_pos, y_pos}, {x_vel, y_vel}} ->
        new_position = {x_pos + x_vel, y_pos + y_vel}

        new_x_velocity =
          cond do
            x_vel > 0 -> x_vel - 1
            x_vel < 0 -> x_vel + 1
            x_vel == 0 -> x_vel
          end

        new_y_velocity = y_vel - 1
        new_velocity = {new_x_velocity, new_y_velocity}

        {new_position, {new_position, new_velocity}}
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
