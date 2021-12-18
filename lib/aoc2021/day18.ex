defmodule Aoc2021.Day18 do
  def part1(input) do
    nil
  end

  def part2(input) do
    nil
  end

  def reduce(pairs) do
    if path = to_explode(pairs) do
      # |> reduce()
      pairs |> explode(path)
    else
      pairs
    end
  end

  def explode(pairs, path) do
    [pair_left, pair_right] = get_in_list(pairs, path)
    {{left_path, _left_elem}, {right_path, _right_elem}} = adjacent_elems(pairs, path)

    res = pairs
    res = if left_path == nil, do: res, else: update_in_list(res, left_path, &(&1 + pair_left))
    res = if right_path == nil, do: res, else: update_in_list(res, right_path, &(&1 + pair_right))

    update_in_list(res, path, fn _ -> 0 end)
  end

  def all_paths(pairs) do
    pairs
    |> all_paths([])
    |> List.flatten()
  end

  def all_paths(elem, path_so_far) when is_integer(elem),
    do: {path_so_far |> Enum.reverse(), elem}

  def all_paths([left, right] = _pairs, path_so_far) do
    [all_paths(left, [0 | path_so_far]), all_paths(right, [1 | path_so_far])]
  end

  def adjacent_elems(pairs, target_path) do
    paths = all_paths(pairs)

    target? = fn {path, _elem} -> List.starts_with?(path, target_path) end
    left_elem_idx = Enum.find_index(paths, target?) - 1
    right_elem_idx = find_last_index(paths, target?) + 1

    left = if left_elem_idx >= 0, do: Enum.at(paths, left_elem_idx)
    right = if right_elem_idx >= 0, do: Enum.at(paths, right_elem_idx)

    {left || {nil, nil}, right || {nil, nil}}
  end

  def to_explode(pair, path \\ [], depth \\ 0)

  def to_explode([left, right], path, 4 = _depth)
      when is_integer(left) and is_integer(right) do
    Enum.reverse(path)
  end

  def to_explode([left, right], path, depth) do
    to_explode(left, [0 | path], depth + 1) || to_explode(right, [1 | path], depth + 1)
  end

  def to_explode(_, _, _), do: nil

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
end
