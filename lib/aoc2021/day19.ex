defmodule Aoc2021.Day19 do

  # ======== YOU SHOULD NOT LOOK AT THIS CODE ========== #
  # It's slow and terrible. It works, but it also sucks. #
  # I warned you.
  # ==================================================== #

  @min_overlap 12

  def part1(input) do
    scans = parse(input)

    scans
    |> merge_all
    |> Enum.count()
  end

  def part2(input) do
    scans = parse(input)
    scanners = scanners_position(scans)

    distances =
      for [x1, y1, z1] <- scanners,
          [x2, y2, z2] <- scanners,
          do: abs(x1 - x2) + abs(y1 - y2) + abs(z1 - z2)

    Enum.max(distances)
  end

  def merge_all([first_scan | scans]), do: merge_all(scans, first_scan)

  def merge_all([scan | other_scans], beacons_map) do
    case merge_normalized(beacons_map, scan) do
      nil ->
        merge_all(other_scans ++ [scan], beacons_map)

      {new_map, _distance} ->
        IO.puts(".")
        merge_all(other_scans, new_map)
    end
  end

  def merge_all([], beacons_map), do: beacons_map

  def scanners_position([first_scan | scans]),
    do: scanners_position(scans, first_scan, [[0, 0, 0]])

  def scanners_position([scan | other_scans], beacons_map, scanners) do
    case merge_normalized(beacons_map, scan) do
      nil ->
        scanners_position(other_scans ++ [scan], beacons_map, scanners)

      {new_map, distance} ->
        IO.puts(".")
        scanners_position(other_scans, new_map, [distance | scanners])
    end
  end

  def scanners_position([], _, scanners), do: scanners

  def merge_normalized(scan1, scan2) do
    res =
      try do
        for rotation <- rotations(),
            scan2 = apply_rotation(scan2, rotation),
            beacon1 <- scan1,
            scan1_distances = distances(scan1, beacon1),
            beacon2 <- scan2 do
          scan2_distances = distances(scan2, beacon2)

          overlap = MapSet.intersection(scan2_distances, scan1_distances)

          if MapSet.size(overlap) >= @min_overlap do
            [dx, dy, dz] = distance(beacon1, beacon2)

            scan2_relative_to_scan1 =
              Enum.map(scan2, fn [x, y, z] -> [x + dx, y + dy, z + dz] end)

            res = scan1 ++ scan2_relative_to_scan1
            throw({Enum.uniq(res), [dx, dy, dz]})
          end
        end
      catch
        res -> {:ok, res}
      end

    case res do
      {:ok, res} -> res
      _ -> nil
    end
  end

  def distances(scan, target_beacon),
    do: MapSet.new(for beacon <- scan, do: distance(beacon, target_beacon))

  def distances_to_beacon(scan, target_beacon),
    do: for(beacon <- scan, into: %{}, do: {distance(beacon, target_beacon), beacon})

  def distance(beacon1, beacon2),
    do: beacon1 |> Enum.zip(beacon2) |> Enum.map(fn {a, b} -> a - b end)


  #####################################
  #    GRAVEYARD OF FAILED ATTEMPTS   #
  # kept here for my future amusement #
  #####################################
  #

  # def overlap(coords1, coords2, axis) do
  #   dist1 = axis_distribution(coords1, axis)
  #   dist2 = axis_distribution(coords2, axis)

  #   IO.puts("Checking: ")
  #   IO.inspect(coords1)
  #   IO.inspect(coords2)

  #   IO.puts("\nDistributions:")
  #   IO.inspect(dist1)
  #   IO.inspect(dist2)
  #   d1 = overlap_between(dist1, dist2)

  #   IO.puts("@@@@ ROUND 2 @@@@")
  #   d2 = overlap_between(dist2, dist1)

  #   IO.inspect(d1, label: "d1")
  #   IO.inspect(d2, label: "d2")
  #   d1 ++ d2
  # end

  # def overlap_between(dist1, dist2), do: overlap_between(dist1, dist2, [])

  # def overlap_between([], _, acc), do: acc

  # def overlap_between([elem1 | rest_dist1] = dist1, [elem2 | _] = dist2, acc) do
  #   acc =
  #     if first_n_overlap?(dist1, dist2),
  #       do: [Enum.unzip(overlapping_chunk(dist1, dist2)) | acc],
  #       else: acc

  #   overlap_between(rest_dist1, dist2, acc)
  # end

  # # def overlap_between([_ | rest_dist1], dist2, acc) do
  # #   overlap_between(rest_dist1, dist2, acc)
  # # end

  # def first_n_overlap?(d1, d2, remaining \\ @min_overlap)

  # def first_n_overlap?(_, _, 0) do
  #   IO.puts("OVERLAP!")
  #   true
  # end

  # def first_n_overlap?([{elem1, _} | rest1] = d1, [{elem2, _} | rest2] = d2, remaining) do
  #   # IO.puts("------")
  #   # IO.inspect(d1)
  #   # IO.inspect(d2)
  #   # IO.inspect(remaining)

  #   if elem1 == elem2 or elem1 == 0 or elem2 == 0 do
  #     first_n_overlap?(rest1, rest2, remaining - 1)
  #   else
  #     false
  #   end
  # end

  # def first_n_overlap?(a, b, c) do
  #   false
  # end

  # def overlapping_chunk(d1, d2), do: overlapping_chunk(d1, d2, [])

  # def overlapping_chunk([{elem1, coord1} | rest1], [{elem2, coord2} | rest2], acc) do
  #   if elem1 == elem2 or elem1 == 0 or elem2 == 0 do
  #     overlapping_chunk(rest1, rest2, [{coord1, coord2} | acc])
  #   else
  #     acc
  #   end
  # end

  # def overlapping_chunk(_, _, acc), do: acc

  # def axis_distribution(coordinates, axis) do
  #   sorted_by_axis = Enum.sort_by(coordinates, fn coord -> Enum.at(coord, axis) end)

  #   distribution =
  #     sorted_by_axis
  #     |> Enum.chunk_every(2, 1, :discard)
  #     |> Enum.map(fn [prev_coord, curr_coord] ->
  #       distance_on_axis = Enum.at(curr_coord, axis) - Enum.at(prev_coord, axis)
  #       {distance_on_axis, curr_coord}
  #     end)

  #   # TODO: e' giusto ignorare il primo?
  #   [{0, List.first(sorted_by_axis)} | distribution]
  #   # distribution
  # end

  def apply_rotation(coordinates, [{x, x_direction}, {y, y_direction}, {z, z_direction}]) do
    for coordinate <- coordinates do
      [
        Enum.at(coordinate, x) * x_direction,
        Enum.at(coordinate, y) * y_direction,
        Enum.at(coordinate, z) * z_direction
      ]
    end
  end

  def rotations() do
    for x <- 0..2,
        y <- 0..2,
        x != y,
        z = ([0, 1, 2] -- [x, y]) |> Enum.at(0),
        x_direction <- [-1, 1],
        y_direction <- [-1, 1],
        z_direction <- [-1, 1],
        rotation = [{x, x_direction}, {y, y_direction}, {z, z_direction}],
        not mirror?(rotation),
        do: rotation
  end

  def mirror?(rotation) do
    # See https://en.wikipedia.org/wiki/Right-hand_rule#Coordinates
    directions = Enum.map(rotation, fn {_, direction} -> direction end)
    mirrors_direction? = Enum.count(directions, &(&1 == -1)) in [1, 3]

    axes = Enum.map(rotation, fn {axis, _} -> axis end)
    swaps_two_axes? = axes in [[0, 2, 1], [2, 1, 0], [1, 0, 2]]

    # is there a better way to do a boolean xor?
    (mirrors_direction? or swaps_two_axes?) and not (mirrors_direction? and swaps_two_axes?)
  end

  def parse(input) do
    scanners = String.split(input, "\n\n", trim: true)

    for scanner <- scanners do
      scanner
      |> String.split("\n", trim: true)
      |> tl()
      |> Enum.map(&String.split(&1, ",", trim: true))
      |> Enum.map(fn coordinates -> Enum.map(coordinates, &String.to_integer(&1)) end)
    end
  end
end
