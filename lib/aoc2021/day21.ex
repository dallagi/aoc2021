defmodule DeterministicDice do
  @sides 100

  use Agent

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

    losing_score = game.state |> Map.values() |> get_in([Access.all(), :score]) |> Enum.min()
    losing_score * DeterministicDice.rolls()
  end

  def part2(input) do
    nil
  end

  defp play(%{players: players, state: game_state, turn: turn} = game) do
    player = Enum.at(players, rem(turn, length(players)))
    rolls = for _ <- 1..3, do: DeterministicDice.roll()
    roll_result = Enum.sum(rolls)

    game =
      game
      |> update_in([:state, player], fn %{position: position, score: score} ->
        new_position = rem(position + roll_result, @board_size)
        %{position: new_position, score: score + new_position + 1}
      end)
      |> update_in([:turn], &(&1 + 1))
    if finished?(game), do: game, else: play(game)
  end

  defp finished?(game) do
    Enum.any?(
      Map.values(game.state),
      fn %{score: score} -> score >= 1000 end
    )
  end

  defp new_game(players) do
    players_list = for {player, _} <- players, do: player

    state =
      for {player, initial_position} <- players,
          into: %{},
          do: {player, %{position: initial_position - 1, score: 0}}

    %{players: players_list, state: state, turn: 0}
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
