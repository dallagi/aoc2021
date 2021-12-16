defmodule Aoc2021.Day16 do
  def part1(input) do
    nil
  end

  def part2(input) do
    nil
  end

  @literal_type 4

  def decode(<<version::size(3), @literal_type::size(3), payload::bits>>) do
    {:literal, version, decode_literal(payload)}
  end

  defp decode_literal(payload, accumulator \\ <<>>)

  defp decode_literal(<<1::size(1), elem::bits-size(4), payload::bits>>, accumulator) do
    acc = <<accumulator::bits, elem::bits-size(4)>>
    decode_literal(payload, acc)
  end

  defp decode_literal(<<0::size(1), elem::bits-size(4), _padding::bits>>, accumulator) do
    result = <<accumulator::bits, elem::bits-size(4)>>
    result_bit_size = bit_size(result)
    <<result_as_number::integer-size(result_bit_size)>> = result

    result_as_number
  end
end
