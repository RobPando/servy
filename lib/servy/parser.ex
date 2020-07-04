defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [header, params] = String.split(request, "\r\n\r\n")
    [request | header_attr] = String.split(header, "\r\n")
    [method, path, _] = String.split(request, " ")

    headers = parse_headers(header_attr, %{})
    params = parse_params(headers["Content-Type"], params)

    %Conv{
      method: method,
      path: path,
      headers: headers,
      params: params,
    }
  end

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers

  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}
end
