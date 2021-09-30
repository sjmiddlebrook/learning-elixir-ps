defmodule Timer do
  def remind(message, seconds) do
    spawn(
      fn ->
        :timer.sleep(seconds * 1000)
        IO.puts message
      end)
  end
end

#Timer.remind("test", 3)
#:timer.sleep(:infinity)
