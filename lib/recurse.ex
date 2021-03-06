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

  def triple([head|tail]) do
    [head*3 | triple(tail)]
  end

  def triple([]), do: []
end

#IO.puts Recurse.sum([1, 2, 3, 4, 5], 0)
IO.inspect Recurse.triple([1, 2, 3, 4, 5], [])

ranks = [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A" ]
suits = [ "♣", "♦", "♥", "♠" ]
cards = for rank <- ranks, suit <- suits, do: {rank, suit}
hands = cards |> Enum.shuffle |> Enum.chunk_every(13)
IO.inspect hands
