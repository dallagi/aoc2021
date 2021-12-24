defmodule Aoc2021.Day24 do
  @initial_variables for var_name <- ~w(w x y z), into: %{}, do: {var_name, 0}

  @operations %{
    add: &Kernel.+/2,
    mul: &Kernel.*/2,
    div: &__MODULE__.divide/2,
    mod: &__MODULE__.mod/2,
    eql: &__MODULE__.equals/2
  }

  def part1(input) do
    program = parse(input)

    for digit_position <- 0..13 do
      results =
        for digit <- 1..9 do
          number = List.insert_at(for(_ <- 0..13, do: 9), digit_position, digit)
          number_b = List.insert_at(for(_ <- 0..13, do: 8), digit_position, digit)

          run_or_infinity = fn program, number ->
            case run(program, number) do
              {:ok, %{"z" => z}} -> z
              _ -> :infinity
            end
          end

          z = max(run_or_infinity.(program, number), run_or_infinity.(program, number_b))
          {digit, z}
        end

      results
      |> Enum.reject(&(&1 == nil))
      |> Enum.sort_by(fn {_, z} -> z end)
    end
    |> Enum.with_index()
    |> IO.inspect(pretty: true)
  end

  def part2(input) do
    nil
  end

  def run(program, arguments, state \\ nil) do
    res = do_run(program, arguments, state || @initial_variables)
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
end
