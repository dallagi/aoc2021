defmodule Aoc2021 do
  def input_for(day) do
    path =
      Path.join([
        "priv",
        "inputs",
        day
      ])
    File.read!(path)
  end
end
