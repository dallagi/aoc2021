defmodule Aoc2021.Day18 do
  def part1(input) do
    input
    |> parse()
    |> Enum.reduce(fn num, prev_result -> sum(prev_result, num) end)
    |> magnitude()
  end

  def part2(input) do
    numbers = parse(input)

    possible_pairs = for n1 <- numbers, n2 <- numbers, n1 != n2, do: {n1, n2}

    possible_pairs
    |> Enum.map(fn {n1, n2} -> n1 |> sum(n2) |> magnitude() end)
    |> Enum.max()
  end

  def sum(num1, num2), do: reduce([reduce(num1), reduce(num2)])

  def magnitude([left, right]), do: 3 * magnitude(left) + 2 * magnitude(right)
  def magnitude(regular_number), do: regular_number

  def reduce(number) do
    cond do
      path = to_explode(number) -> number |> explode(path) |> reduce()
      path = to_split(number) -> number |> split(path) |> reduce()
      true -> number
    end
  end

  def explode(number, path) do
    [num_left, num_right] = get_in_list(number, path)
    {{left_path, _left_elem}, {right_path, _right_elem}} = adjacent_elems(number, path)

    res = number
    res = if left_path == nil, do: res, else: update_in_list(res, left_path, &(&1 + num_left))
    res = if right_path == nil, do: res, else: update_in_list(res, right_path, &(&1 + num_right))

    update_in_list(res, path, fn _ -> 0 end)
  end

  def split(number, path) do
    update_in_list(number, path, fn elem -> [floor(elem / 2), ceil(elem / 2)] end)
  end

  def all_paths(number) do
    number
    |> all_paths([])
    |> List.flatten()
  end

  def all_paths(elem, path_so_far) when is_integer(elem),
    do: {path_so_far |> Enum.reverse(), elem}

  def all_paths([left, right] = _pairs, path_so_far) do
    [all_paths(left, [0 | path_so_far]), all_paths(right, [1 | path_so_far])]
  end

  def adjacent_elems(number, target_path) do
    paths = all_paths(number)

    target? = fn {path, _elem} -> List.starts_with?(path, target_path) end
    left_elem_idx = Enum.find_index(paths, target?) - 1
    right_elem_idx = find_last_index(paths, target?) + 1

    left = if left_elem_idx >= 0, do: Enum.at(paths, left_elem_idx)
    right = if right_elem_idx >= 0, do: Enum.at(paths, right_elem_idx)

    {left || {nil, nil}, right || {nil, nil}}
  end

  def to_explode(number, path \\ [], depth \\ 0) do
    case number do
      [left, right] when depth == 4 and is_integer(left) and is_integer(right) ->
        Enum.reverse(path)

      [left, right] ->
        to_explode(left, [0 | path], depth + 1) || to_explode(right, [1 | path], depth + 1)

      _ ->
        nil
    end
  end

  def to_split(elem, path \\ []) do
    case elem do
      [left, right] -> to_split(left, [0 | path]) || to_split(right, [1 | path])
      elem when elem >= 10 -> Enum.reverse(path)
      _ -> nil
    end
  end

  def get_in_list(list, path) do
    accessor = for idx <- path, do: Access.at(idx)
    get_in(list, accessor)
  end

  def update_in_list(list, path, function) do
    accessor = for idx <- path, do: Access.at(idx)
    update_in(list, accessor, function)
  end

  defp find_last_index(list, fun) do
    list
    |> Enum.with_index()
    |> Enum.reduce(nil, fn
      {elem, idx}, acc -> if fun.(elem), do: idx, else: acc
    end)
  end

  defp parse(input) do
    for row <- String.split(input, "\n", trim: true),
        {number, _} = Code.eval_string(row),
        do: number
  end
end
