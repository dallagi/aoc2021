defmodule DeterministicDice do
  use Agent
  @sides 100

  def start_link(), do: Agent.start_link(fn -> {0, 0} end, name: __MODULE__)

  def roll() do
    Agent.get_and_update(__MODULE__, fn {last_value, rolls} ->
      new_value = if last_value < @sides, do: last_value + 1, else: 1
      {new_value, {new_value, rolls + 1}}
    end)
  end

  def rolls(), do: Agent.get(__MODULE__, fn {_, rolls} -> rolls end)
end

defmodule Memo do
  use Agent

  def start_link(), do: Agent.start_link(fn -> %{} end, name: __MODULE__)
  def set(key, value), do: Agent.update(__MODULE__, &Map.put(&1, key, value))
  def get(key), do: Agent.get(__MODULE__, &Map.get(&1, key))
end

defmodule Aoc2021.Day21 do
  @board_size 10

  def part1(input) do
    DeterministicDice.start_link()

    roll = fn ->
      rolls = for _ <- 1..3, do: DeterministicDice.roll()
      Enum.sum(rolls)
    end

    game =
      input
      |> parse()
      |> play(roll, 1000)

    losing_score = game.players |> Enum.map(&elem(&1, 1)) |> Enum.min()
    losing_score * DeterministicDice.rolls()
  end

  def part2(input) do
    Memo.start_link()
    game = parse(input)
    {p1, p2} = winning_universes(game, 21)
    max(p1, p2)
  end

  defp winning_universes(game, win_score) do
    if result = Memo.get(game) do
      result
    else
      case winner(game, win_score) do
        0 ->
          {1, 0}

        1 ->
          {0, 1}

        nil ->
          possible_rolls = for d1 <- 1..3, d2 <- 1..3, d3 <- 1..3, do: d1 + d2 + d3

          for roll <- possible_rolls, reduce: {0, 0} do
            {total_p1_wins, total_p2_wins} ->
              game = play_turn(game, fn -> roll end)
              {p1_wins, p2_wins} = winning_universes(game, win_score)
              {total_p1_wins + p1_wins, total_p2_wins + p2_wins}
          end
      end
      |> tap(&Memo.set(game, &1))
    end
  end

  defp play(game, roll, win_score) do
    game = play_turn(game, roll)
    if winner(game, win_score) != nil, do: game, else: play(game, roll, win_score)
  end

  defp play_turn(game, roll) do
    roll_result = roll.()

    game
    |> update_in([:players, Access.at(game.player_playing)], fn {position, score} ->
      new_position = rem(position + roll_result, @board_size)
      {new_position, score + new_position + 1}
    end)
    |> update_in([:player_playing], &(1 - &1))
  end

  defp winner(game, win_score) do
    Enum.find_index(game.players, fn {_pos, score} -> score >= win_score end)
  end

  defp new_game(players) do
    players = for {_player, initial_position} <- players, do: {initial_position - 1, 0}

    %{players: players, player_playing: 0}
  end

  defp parse(input) do
    players =
      for row <- String.split(input, "\n", trim: true) do
        [_, player, _, _, initial_position] = String.split(row, " ", trim: true)
        {player, String.to_integer(initial_position)}
      end

    new_game(players)
  end
end
