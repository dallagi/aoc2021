defmodule Aoc2021.Day4 do
  def part1(input) do
    {numbers, boards} = parse(input)

    boards = Enum.map(boards, &build_board/1)

    {winning_board, marked_numbers, last_marked_number} =
      Enum.reduce_while(numbers, MapSet.new(), fn number, numbers ->
        numbers = MapSet.put(numbers, number)
        winning_board = Enum.find(boards, &winning_board?(&1, numbers))
        if winning_board, do: {:halt, {winning_board, numbers, number}}, else: {:cont, numbers}
      end)

    score(winning_board, marked_numbers, last_marked_number)
  end

  def part2(input) do
    {all_numbers, boards} = parse(input)

    boards = Enum.map(boards, &build_board/1)

    {_, last_winning_board, _} =
      Enum.reduce(
        all_numbers,
        {MapSet.new(), [], boards},
        fn number, {numbers, last_winning_board, remaining_boards} ->
          numbers = MapSet.put(numbers, number)
          winning_boards = Enum.filter(remaining_boards, &winning_board?(&1, numbers))

          case winning_boards do
            [] ->
              {numbers, last_winning_board, remaining_boards}

            boards ->
              board_info = %{
                board: List.first(boards),
                marked_numbers: numbers,
                last_marked_number: number
              }

              {numbers, board_info, Enum.reject(remaining_boards, &(&1 in winning_boards))}
          end
        end
      )

    score(
      last_winning_board.board,
      last_winning_board.marked_numbers,
      last_winning_board.last_marked_number
    )
  end

  defp winning_board?(%{winning_sets: winning_sets} = _board, numbers) do
    Enum.any?(winning_sets, &MapSet.subset?(&1, numbers))
  end

  defp score(%{numbers: board_numbers} = _board, marked_numbers, last_marked_number) do
    sum_of_unmarked_numbers =
      board_numbers
      |> Enum.reject(&MapSet.member?(marked_numbers, &1))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()

    sum_of_unmarked_numbers * String.to_integer(last_marked_number)
  end

  defp parse(input) do
    [numbers | boards] = String.split(input, "\n\n")
    numbers = String.split(numbers, ",")

    boards =
      boards
      |> Enum.map(fn board ->
        board
        |> String.split("\n", trim: true)
        |> Enum.map(&String.split(&1, " ", trim: true))
      end)

    {numbers, boards}
  end

  defp build_board(board) do
    %{numbers: List.flatten(board), winning_sets: winning_sets(board)}
  end

  defp winning_sets(rows) do
    columns =
      rows
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

    (rows ++ columns)
    |> Enum.map(&MapSet.new/1)
  end
end
