defmodule Aoc2021.Day24Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day24

  # @example_input ""

  test "solves part1 for provided example" do
    # assert nil == Day24.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Day24.part2(@example_input)
  end

  test "xxx" do
    Memo.start_link()
    IO.puts("a")
    program_parts = "24" |> Aoc2021.input_for() |> Day24.parse() |> Day24.split_at_inps()

    IO.puts("a")

    assert [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] ==
             Day24.highest_valid_model_number(
               program_parts,
               [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
               0,
               14
             )

    IO.puts("a")

    assert [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2] ==
             Day24.highest_valid_model_number(
               program_parts,
               [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
               7,
               13
             )

    IO.puts("a")
    IO.puts("========")
    IO.puts("========")
    IO.puts("========")
    IO.puts("========")

    assert [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2] ==
             Day24.highest_valid_model_number(
               program_parts,
               [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
               14,
               12
             )
  end

  test "success" do
    program = "24" |> Aoc2021.input_for() |> Day24.parse()

    assert {:ok, %{"z" => 0}} =
             Day24.run(program, Enum.reverse([3, 1, 1, 4, 1, 4, 1, 7, 1, 1, 3, 9, 6, 1]))
  end

  test "simple ALU program" do
    program = """
    inp x
    mul x -1
    """

    assert {:ok, %{"x" => -10}} = Day24.run(Day24.parse(program), [10])
  end

  test "binary converter ALU program" do
    program = """
    inp w
    add z w
    mod z 2
    div w 2
    add y w
    mod y 2
    div w 2
    add x w
    mod x 2
    div w 2
    mod w 2
    """

    assert {:ok, %{"w" => 0, "x" => 1, "y" => 0, "z" => 1}} = Day24.run(Day24.parse(program), [5])
  end

  test "raises on division by 0" do
    program = """
    inp w
    div w 0
    """

    assert {:error, _} = Day24.run(Day24.parse(program), [1])
  end

  test "first part of given program" do
    program = """
    inp w
    mul x 0
    add x z
    mod x 26
    div z 1
    add x 14
    eql x w
    eql x 0
    mul y 0
    add y 25
    mul y x
    add y 1
    mul z y
    mul y 0
    add y w
    add y 8
    mul y x
    add z y
    """

    input = 1

    assert {:ok, %{"w" => input, "x" => 1, "y" => input + 8, "z" => input + 8}} ==
             Day24.run(Day24.parse(program), [input])
  end

  test "second part" do
    program =
      """
      inp w
      mul x 0
      add x z
      mod x 26
      div z 1
      add x 13
      eql x w
      eql x 0
      mul y 0
      add y 25
      mul y x
      add y 1
      mul z y
      mul y 0
      add y w
      add y 8
      mul y x
      add z y
      """
      |> Day24.parse()

    input = 123
    z = 234
    expected_z = z * 26 + (input + 8)

    assert {:ok, %{"z" => ^expected_z}} =
             Day24.run(program, [input], %{"x" => 0, "y" => 0, "z" => z, "w" => 0})
  end

  test "third part" do
    program =
      """
      inp w
      mul x 0
      add x z
      mod x 26
      div z 1
      add x 13
      eql x w
      eql x 0
      mul y 0
      add y 25
      mul y x
      add y 1
      mul z y
      mul y 0
      add y w
      add y 3
      mul y x
      add z y
      """
      |> Day24.parse()

    input = 123
    z = 234
    expected_z = z * 26 + (input + 3)

    assert {:ok, %{"z" => ^expected_z}} =
             Day24.run(program, [input], %{"x" => 0, "y" => 0, "z" => z, "w" => 0})
  end

  test "fifth part" do
    program =
      """
      inp w
      mul x 0
      add x z
      mod x 26
      div z 26
      add x -12
      eql x w
      eql x 0
      mul y 0
      add y 25
      mul y x
      add y 1
      mul z y
      mul y 0
      add y w
      add y 8
      mul y x
      add z y
      """
      |> Day24.parse()

    # if input + 12 == z % 26, z -> z / 26
    input = 5
    z = 26 * 123 + 5 + 12
    expected_z = div(z, 26)

    assert {:ok, %{"z" => ^expected_z}} =
             Day24.run(program, [input], %{"x" => 0, "y" => 0, "z" => z, "w" => 0})

    # otherwise, z = (z / 26) + 34 + input

    input = 5
    z = 26 * 123 + 5 + 13
    expected_z = div(z, 26) * 26 + 8 + input

    assert {:ok, %{"z" => ^expected_z}} =
             Day24.run(program, [input], %{"x" => 0, "y" => 0, "z" => z, "w" => 0})
  end
end
