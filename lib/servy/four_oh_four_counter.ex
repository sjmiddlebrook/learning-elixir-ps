defmodule Servy.FourOhFourCounter do

  @name __MODULE__

  def start() do
    pid = spawn(__MODULE__, :listen_loop, [%{}])
    Process.register(pid, @name)
    pid
  end

  def bump_count(path) do
    send(@name, {:add_count, path})
  end

  def get_count(path) do
    send(@name, {self(), :get_count, path})
    receive do {:response, total} -> total end
  end

  def get_counts() do
    send(@name, {self(), :get_counts})
    receive do {:response, state} -> state end
  end

  def listen_loop(state) do
    receive do
      {:add_count, path} ->
        # update state to increment path
        new_state = Map.update(state, path, 1, fn existing_value -> existing_value + 1 end)
        listen_loop(new_state)
      {sender, :get_count, path} ->
        # get for single path
        total = Map.get(state, path, 0)
        send(sender, {:response, total})
        listen_loop(state)
      {sender, :get_counts} ->
        # get for all paths
        send(sender, {:response, state})
        listen_loop(state)
      unexpected ->
        IO.puts "Unexpected message: #{inspect unexpected}"
        listen_loop(state)
    end
  end

end