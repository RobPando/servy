defmodule Servy.Plugins do
  alias Servy.Conv
  def rewrite_path(%Conv{path: "/whatwewanttodo"} = conv) do
    %{conv | path: "/todo"}
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def track(%Conv{ status: 404, path: path } = conv) do
    IO.puts "#{path} couldnt be found"
    conv
  end

  def track(%Conv{} = conv), do: conv
end
