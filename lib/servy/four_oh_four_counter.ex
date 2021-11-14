defmodule Servy.FourOhFourCounter do

  @name __MODULE__

  use GenServer

  def start() do
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  def bump_count(path) do
    GenServer.call(@name, {:add_count, path})
  end

  def get_count(path) do
    GenServer.call(@name, {:get_count, path})
  end

  def get_counts() do
    GenServer.call(@name, :get_counts)
  end

  def reset() do
    GenServer.cast(@name, :reset)
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_call({:add_count, path}, _from, state) do
    new_state = Map.update(state, path, 1, fn existing_value -> existing_value + 1 end)
    {:reply, new_state, new_state}
  end

  def handle_call({:get_count, path}, _from, state) do
    total = Map.get(state, path, 0)
    {:reply, total, state}
  end

  def handle_call(:get_counts, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:reset, _state) do
    {:noreply, %{}}
  end

end