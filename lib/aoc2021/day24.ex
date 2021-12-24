defmodule Aoc2021.Day24 do
  @initial_variables for var_name <- ~w(w x y z), into: %{}, do: {var_name, 0}
  @steps_that_can_lower_z for idx <- 0..13,
                              into: %{},
                              do: {idx, Enum.count([4, 6, 7, 10, 11, 12, 13], &(&1 >= idx))}

  @operations %{
    add: &Kernel.+/2,
    mul: &Kernel.*/2,
    div: &__MODULE__.divide/2,
    mod: &__MODULE__.mod/2,
    eql: &__MODULE__.equals/2
  }

  def part1(input) do
    Memo.start_link()

    IO.inspect(@steps_that_can_lower_z)

    program =
      input
      |> parse
      |> split_at_inps()
      |> highest_valid_model_number()
  end

  def part2(input) do
    nil
  end

  def highest_valid_model_number(program_parts, prefix \\ [], z \\ 0, prefix_length \\ 0) do
    cond do
      res = Memo.get({prefix_length, z}) != nil ->
        res

      prefix_length == 14 and z == 0 ->
        IO.inspect(prefix, label: "success!")
        prefix

      prefix_length == 14 ->
        nil

      # can only do z = z / 26 per each digit
      z >= 26 ** @steps_that_can_lower_z[prefix_length] ->
        nil

      true ->
        valid_numbers =
          for digit <- 9..1 do
            program = Enum.at(program_parts, prefix_length + 1)

            case run(program, [digit], %{"z" => z}) do
              {:ok, %{"z" => new_z}} ->
                highest_valid_model_number(
                  program_parts,
                  [digit | prefix],
                  new_z,
                  prefix_length + 1
                )

              _ ->
                nil
            end
          end

        valid_numbers
        |> Enum.reject(&(&1 == nil))
        |> Enum.max_by(&(&1 |> Enum.reverse() |> Integer.undigits()), fn -> nil end)
    end
    |> tap(fn res -> Memo.set({prefix_length, z}, res) end)
  end

  def run(program, arguments, state \\ %{}) do
    # IO.inspect(program)
    # IO.inspect(arguments)
    state = Map.merge(@initial_variables, state)
    res = do_run(program, arguments, state)
    # IO.inspect(res)
    {:ok, res}
  rescue
    e in RuntimeError -> {:error, e}
  end

  def do_run([], _, variables), do: variables

  def do_run([{:inp, var} | program], [arg | args], variables),
    do: do_run(program, args, Map.put(variables, var, arg))

  def do_run([{op, a, b} | program], args, variables) do
    operation = Map.get(@operations, op)
    result = operation.(value(variables, a), value(variables, b))
    do_run(program, args, Map.put(variables, a, result))
  end

  def equals(val, val), do: 1
  def equals(_, _), do: 0

  def mod(a, b) when a < 0 or b <= 0, do: raise(RuntimeError, message: "Invalid mod operands")
  def mod(a, b), do: rem(a, b)

  def divide(_, 0), do: raise(RuntimeError, message: "Invalid divisor")
  def divide(a, b), do: div(a, b)

  def value(variables, var), do: Map.get(variables, var) || String.to_integer(var)

  def parse(program_code) do
    for line <- String.split(program_code, "\n", trim: true) do
      _known_ops = ~w(add mul div mod eql)

      case String.split(line, " ", trime: true) do
        ["inp", arg] -> {:inp, arg}
        [op, a, b] -> {String.to_existing_atom(op), a, b}
      end
    end
  end

  def split_at_inps(program) do
    {res, last_chunk} =
      for instruction <- program, reduce: {[], []} do
        {res, this_chunk} ->
          case instruction do
            # too tired to do it correctly by reversing
            ins = {:inp, _} -> {res ++ [this_chunk], [ins]}
            ins -> {res, this_chunk ++ [ins]}
          end
      end

    res ++ [last_chunk]
  end
end
