defmodule Servy.FourOhFourCounter do

  @name __MODULE__

  alias Servy.GenericServer

  def start() do
    GenericServer.start(__MODULE__, %{}, @name)
  end

  def bump_count(path) do
    GenericServer.call(@name, {:add_count, path})
  end

  def get_count(path) do
    GenericServer.call(@name, {:get_count, path})
  end

  def get_counts() do
    GenericServer.call(@name, :get_counts)
  end

  def reset() do
    GenericServer.cast(@name, :reset)
  end

  def handle_call({:add_count, path}, state) do
    new_state = Map.update(state, path, 1, fn existing_value -> existing_value + 1 end)
    {new_state, new_state}
  end

  def handle_call({:get_count, path}, state) do
    total = Map.get(state, path, 0)
    {total, state}
  end

  def handle_call(:get_counts, state) do
    {state, state}
  end

  def handle_cast(:reset, _state) do
    %{}
  end

end