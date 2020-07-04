defmodule Servy.Router do
  alias Servy.Conv
  alias Servy.Controllers.{Api, LanguagesController, DonationsController}

  @pages_path Path.expand("../../pages", __DIR__)

  def route(%Conv{method: "GET", path: "/todo"} = conv) do
    @pages_path
    |> Path.join("todo.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/donations"} = conv) do
    DonationsController.index(conv)
  end

  def route(%Conv{method: "POST", path: "/donations"} = conv) do
    DonationsController.create(conv, conv.params)
  end

  def route(%Conv{method: "GET", path: "/api/v1/languages"} = conv) do
    Api.V1.LanguagesController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/language/" <> id} = conv) do
    params = Map.put(conv.params, "id", String.to_integer(id))
    LanguagesController.show(conv, params)
  end

  def route(%Conv{method: "POST", path: "/languages"} = conv) do
    LanguagesController.create(conv, conv.params)
  end

  def route(%Conv{method: "GET", path: "/learning_resources"} = conv) do
    Api.V1.LearningResourcesController.index(conv)
  end

  def route(%Conv{path: path} = conv) do
    %Conv{ conv | status: 404, resp_body: "no route matches #{path}" }
  end

  defp handle_file({:ok, content}, conv) do
    %Conv{ conv | status: 200, resp_body: content }
  end

  defp handle_file({:error, :enoent}, conv) do
    %Conv{ conv | status: 404, resp_body: "File not found!" }
  end

  defp handle_file({:error, reason}, conv) do
    %Conv{ conv | status: 500, resp_body: "File error: #{reason}" }
  end
end
