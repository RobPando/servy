defmodule Servy.Controllers.LanguagesController do
  alias Servy.ProgrammingLanguages

  @language_templates_path Path.expand("../../../templates/languages", __DIR__)

  def index(conv) do
    languages = ProgrammingLanguages.list_languages() |> Enum.sort(&(&1 <= &2))
    render(conv, "index.eex", languages: languages)
  end

  def show(conv, %{"id" => id}) do
    language = ProgrammingLanguages.get_language(id)
    render(conv, "show.eex", language: language)
  end

  def create(conv, %{"name" => name}) do
    %{ conv | status: 201, resp_body: "Programming Language #{name} has been created" }
  end

  defp render(conv, template, assigns) do
    content =
      @language_templates_path
      |> Path.join(template)
      |> EEx.eval_file(assigns)

    %{ conv | status: 200, resp_body: content }
  end
end
