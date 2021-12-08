defmodule Aoc2021.Day8Test do
  use ExUnit.Case, async: true

  @example_input """
  be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
  edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
  fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
  fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
  aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
  fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
  dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
  bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
  egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
  gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
  """

  test "solves part1 for provided example" do
    assert 26 == Aoc2021.Day8.part1(@example_input)
  end

  test "decodes digits from patterns" do
    example_patterns = ~w(acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab)

    assert %{
             MapSet.new(~w(a c e d g f b)) => 8,
             MapSet.new(~w(c d f b e)) => 5,
             MapSet.new(~w(g c d f a)) => 2,
             MapSet.new(~w(f b c a d)) => 3,
             MapSet.new(~w(d a b)) => 7,
             MapSet.new(~w(c e f a b d)) => 9,
             MapSet.new(~w(c d f g e b)) => 6,
             MapSet.new(~w(e a f b)) => 4,
             MapSet.new(~w(c a g e d b)) => 0,
             MapSet.new(~w(a b)) => 1
           } == Aoc2021.Day8.decode_patterns(example_patterns)
  end

  test "solves part2 for provided example" do
    assert 61229 == Aoc2021.Day8.part2(@example_input)
  end
end
