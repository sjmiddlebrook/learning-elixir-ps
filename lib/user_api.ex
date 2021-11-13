defmodule UserApi do
  @moduledoc """
  Documentation for `UserApi`.
  """

  def query(id) do
    api_url(id)
    |> HTTPoison.get
    |> handle_response
  end

  def api_url(id) do
    "https://jsonplaceholder.typicode.com/users/#{URI.encode(id)}"
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    city =
      Jason.decode!(body)
      |> get_in(["address", "city"])

    {:ok, city}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: _status, body: body}}) do
    message =
      Jason.decode!(body)
      |> get_in(["message"])

    {:error, message}
  end
end
