defmodule Servy.Parser do

  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\r\n\r\n")

    [request_line | header_lines] = String.split(top, "\r\n")

    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines)

    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  @doc """
  Parses param string into a map with keys and values

  ## Examples
    iex> params_string = "name=Jia Jia&type=Panda"
    iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", params_string)
    %{"name" => "Jia Jia", "type" => "Panda"}
    iex> Servy.Parser.parse_params("multipart/form-data", params_string)
    %{}
  """

  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim |> URI.decode_query
  end

  def parse_params(_, _), do: %{}

#  def parse_headers([head | tail], headers) do
#    [key, value] = String.split(head, ": ")
#    headers = Map.put(headers, key, value)
#    parse_headers(tail, headers)
#  end
#
#  def parse_headers([], headers), do: headers

  def parse_headers(headers) do
    Enum.reduce(headers, %{}, fn (item, acc) ->
      [key, value] = String.split(item, ": ")
      Map.put(acc, key, value)
    end)
  end
end
