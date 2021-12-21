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

defmodule Aoc2021.Day21 do
  @board_size 10

  def part1(input) do
    DeterministicDice.start_link()

    game =
      input
      |> parse()
      |> play()

    losing_score = game.players |> Enum.map(&elem(&1, 1)) |> Enum.min()
    losing_score * DeterministicDice.rolls()
  end

  def part2(input) do
    nil
  end

  defp play(game) do
    rolls = for _ <- 1..3, do: DeterministicDice.roll()
    roll_result = Enum.sum(rolls)

    game =
      game
      |> update_in([:players, Access.at(game.player_playing)], fn {position, score} ->
        new_position = rem(position + roll_result, @board_size)
        {new_position, score + new_position + 1}
      end)
      |> update_in([:player_playing], &(1 - &1))

    if finished?(game), do: game, else: play(game)
  end

  defp finished?(game) do
    Enum.any?(game.players, fn {_pos, score} -> score >= 1000 end)
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
