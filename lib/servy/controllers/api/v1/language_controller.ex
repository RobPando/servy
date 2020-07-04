defmodule Servy.Controllers.Api.V1.LanguagesController do
  alias Servy.ProgrammingLanguages

  def index(conv) do
    json = ProgrammingLanguages.list_languages() |> Jason.encode!

    %{conv | status: 200, resp_content_type: "application/json", resp_body: json}
  end
end
