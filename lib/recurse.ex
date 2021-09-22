defmodule Recurse do
  def sum([head | tail], count) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"
    sum(tail, count + head)
  end

  def sum([], count), do: count

  def triple([head | tail], tripled) do
    triple(tail, [head * 3 | tripled])
  end

  def triple([], tripled) do
    tripled |> Enum.reverse()
  end
end

#IO.puts Recurse.sum([1, 2, 3, 4, 5], 0)
IO.inspect Recurse.triple([1, 2, 3, 4, 5], [])
