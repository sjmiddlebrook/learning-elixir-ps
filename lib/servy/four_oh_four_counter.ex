defmodule Servy.FourOhFourCounter do

  @name __MODULE__

  def start() do
    pid = spawn(__MODULE__, :listen_loop, [%{}])
    Process.register(pid, @name)
    pid
  end

  def bump_count(endpoint) do
    send(@name, {:add_count, endpoint})
  end

  def get_count(endpoint) do
    send(@name, {self(), :get_count, endpoint})
    receive do {:response, total} -> total end
  end

  def get_counts() do
    send(@name, {self(), :get_counts})
    receive do {:response, state} -> state end
  end

  def listen_loop(state) do
    receive do
      {:add_count, endpoint} ->
        # update state to increment endpoint
        new_state = Map.update(state, endpoint, 1, fn existing_value -> existing_value + 1 end)
        listen_loop(new_state)
      {sender, :get_count, endpoint} ->
        # get for single endpoint
        total = Map.get(state, endpoint, 0)
        send(sender, {:response, total})
        listen_loop(state)
      {sender, :get_counts} ->
        # get for all endpoints
        send(sender, {:response, state})
        listen_loop(state)
      unexpected ->
        IO.puts "Unexpected message: #{inspect unexpected}"
        listen_loop(state)
    end
  end

end