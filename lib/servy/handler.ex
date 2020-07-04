defmodule Servy.Handler do
  @moduledoc "Handles http requests."
  import Servy.Plugins, only: [rewrite_path: 1, track: 1]
  import Servy.Parser, only: [parse: 1]

  alias Servy.Router

  @doc "Transforms a requests into a response"
  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> Router.route()
    |> track()
    |> format_response()
  end

  defp format_response(conv) do
    IO.inspect(conv)
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: #{conv.resp_content_type}
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error",
    }[code]
  end
end
