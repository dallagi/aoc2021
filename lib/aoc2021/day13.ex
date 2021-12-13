defmodule Aoc2021.Day13 do
  def part1(input) do
    {dots, [first_fold | _]} = parse(input)

    dots
    |> fold(first_fold)
    |> length()
  end

  def part2(input) do
    {dots, folds} = parse(input)

    folds
    |> Enum.reduce(dots, &fold(&2, &1))
    |> print()
  end

  defp fold(dots, {axis, value} = _fold_line) do
    case axis do
      :x ->
        for {x, y} <- dots,
            uniq: true do
          new_x = if x > value, do: value - (x - value), else: x
          {new_x, y}
        end

      :y ->
        for {x, y} <- dots,
            uniq: true do
          new_y = if y > value, do: value - (y - value), else: y
          {x, new_y}
        end
    end
  end

  defp parse(input) do
    [dots_raw, folds_raw] = String.split(input, "\n\n", trim: true)

    dots =
      for row <- String.split(dots_raw, "\n", trim: true),
          [x, y] = String.split(row, ","),
          do: {String.to_integer(x), String.to_integer(y)}

    folds =
      Enum.map(String.split(folds_raw, "\n", trim: true), fn
        "fold along x=" <> val -> {:x, String.to_integer(val)}
        "fold along y=" <> val -> {:y, String.to_integer(val)}
      end)

    {dots, folds}
  end

  defp print(dots) do
    max_x = elem(Enum.max_by(dots, fn {x, _y} -> x end), 0)
    max_y = elem(Enum.max_by(dots, fn {_x, y} -> y end), 1)

    for y <- 0..max_y,
        x <- 0..max_x do
      if {x, y} in dots, do: IO.write("#"), else: IO.write(".")
      if x == max_x, do: IO.puts("")
    end

    dots
  end
end
