defmodule Aoc2021.Day16 do
  def part1(input) do
    nil
  end

  def part2(input) do
    nil
  end

  @literal_type 4

  def decode(<<version::size(3), @literal_type::size(3), rest::bits>>) do
    {literal_payload, rest} = decode_literal(rest)
    {{:literal, version, literal_payload}, rest}
  end

  def decode(<<version::size(3), operator_type::size(3), rest::bits>>) do
    {operator_payload, rest} = decode_operator(rest)
    {{:operator, version, operator_type, operator_payload}, rest}
  end

  def decode(_), do: {nil, nil}

  defp decode_literal(payload, accumulator \\ <<>>)

  defp decode_literal(<<1::size(1), elem::bits-size(4), payload::bits>>, accumulator) do
    acc = <<accumulator::bits, elem::bits-size(4)>>
    decode_literal(payload, acc)
  end

  defp decode_literal(<<0::size(1), elem::bits-size(4), rest::bits>>, accumulator) do
    result = bitstring_to_integer(<<accumulator::bits, elem::bits-size(4)>>)
    {result, rest}
  end

  defp decode_operator(payload)

  defp decode_operator(<<0::size(1), length::size(15), payload::bits-size(length), rest::bits>>) do
    {decode_packets(payload), rest}
  end

  defp decode_operator(<<1::size(1), subpackets_count::size(11), rest::bits>>) do
    decode_n_packets(rest, subpackets_count)
  end

  defp decode_packets(payload, accumulator \\ []) do
    {packet_chunk, rest} = decode(payload)
    if packet_chunk != nil do
      decode_packets(rest, [packet_chunk | accumulator])
    else
      Enum.reverse(accumulator)
    end
  end

  defp decode_n_packets(payload, count, accumulator \\ []) do
    if count == 0 do
      {Enum.reverse(accumulator), payload}
    else
      {packet_chunk, rest} = decode(payload)
      decode_n_packets(rest, count - 1, [packet_chunk | accumulator])
    end
  end

  defp bitstring_to_integer(bitstring) do
    size = bit_size(bitstring)
    <<int_result::integer-size(size)>> = bitstring

    int_result
  end
end
