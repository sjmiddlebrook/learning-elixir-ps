defmodule Servy.Wildthings do
  alias Servy.Bear

  def list_bears do
    Path.expand("../../db", __DIR__)
    |> Path.join("bears.json")
    |> read_json
    |> parse_json
    |> initialize_bears
  end

  defp initialize_bears(bear_list) do
    for bear <- bear_list do
      struct(Bear, bear)
    end
  end

  defp parse_json(json) do
    Jason.decode!(json, keys: :atoms) |> Map.get(:bears)
  end

  defp read_json(source) do
    case File.read(source) do
      {:ok, contents} ->
        contents
      {:error, reason} ->
        IO.inspect "Error reading #{source}: #{reason}"
        "[]"
    end
  end

  def get_bear(id) when is_integer(id) do
    Enum.find(list_bears(), fn(item) -> item.id == id end)
  end

  def get_bear(id) when is_binary(id) do
    id |> String.to_integer |> get_bear
  end
end
