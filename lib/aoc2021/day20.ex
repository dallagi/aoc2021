defmodule Aoc2021.Day20 do
  @padding 2

  def part1(input) do
    {algorithm, image} = parse(input)

    image
    |> enhance(algorithm)
    |> enhance(algorithm)
    |> lit_pixels_count()
  end

  def part2(input) do
    nil
  end

  def lit_pixels_count(%{image: image}),
    do: image |> Map.filter(fn {_, p} -> p == 1 end) |> Enum.count()

  def enhance(%{image: image, background: background}, algorithm) do
    {{min_x, max_x}, {min_y, max_y}} = image_boundaries(image)

    background_square = for _ <- 1..9, do: background
    new_background = background_square |> Integer.undigits(2) |> then(&Enum.at(algorithm, &1))

    enhanced_image =
      for y <- (min_y - @padding)..(max_y + @padding),
          x <- (min_x - @padding)..(max_x + @padding),
          into: %{} do
        pixel_value = image |> square_around(x, y, background) |> Integer.undigits(2)
        new_pixel = Enum.at(algorithm, pixel_value)

        {{x + @padding, y + @padding}, new_pixel}
      end

    %{image: enhanced_image, background: new_background}
  end

  def square_around(image, target_x, target_y, background) do
    for delta_y <- -1..1, delta_x <- -1..1 do
      x = target_x + delta_x
      y = target_y + delta_y

      if x < 0 || y < 0, do: background, else: Map.get(image, {x, y}, background)
    end
  end

  defp parse(input) do
    [algorithm, image] = String.split(input, "\n\n", trim: true)

    parse_pixel = fn
      "#" -> 1
      "." -> 0
    end

    algorithm = algorithm |> String.graphemes() |> Enum.map(parse_pixel)

    image =
      for {row, y} <- image |> String.split("\n", trim: true) |> Enum.with_index(),
          {pixel, x} <- row |> String.graphemes() |> Enum.with_index(),
          pixel_value = parse_pixel.(pixel),
          into: %{},
          do: {{x, y}, pixel_value}

    {algorithm, %{image: image, background: 0}}
  end

  def print(image) do
    IO.puts("")
    {{min_x, max_x}, {min_y, max_y}} = image_boundaries(image)

    for y <- min_y..max_y do
      for x <- min_x..max_x do
        if image[{x, y}] == 0, do: IO.write("."), else: IO.write("#")
      end

      IO.puts("")
    end

    image
  end

  def image_boundaries(image) do
    {min_x, max_x} = image |> Enum.map(fn {{x, _}, _} -> x end) |> Enum.min_max()
    {min_y, max_y} = image |> Enum.map(fn {{_, y}, _} -> y end) |> Enum.min_max()

    {{min_x, max_x}, {min_y, max_y}}
  end
end
