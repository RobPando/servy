defmodule Servy.Controllers.Api.V1.LearningResourcesController do
  alias Servy.ProgrammingLanguages.LearningResource

  @available_resources ["elixir", "ruby", "rust"]

  def index(conv) do
    resources =
      @available_resources
      |> Enum.map(&Task.async(fn -> LearningResource.get_resource(&1) end))
      |> Enum.map(&Task.await(&1))
      |> Jason.encode!


    # Uncomment below and comment above code to see difference in fetching time
    # with and without Task async await

    # elixir_resource = LearningResource.get_resource("elixir")
    # ruby_resource = LearningResource.get_resource("ruby")
    # rust_resource = LearningResource.get_resource("rust")
    # resources = [elixir_resource, ruby_resource, rust_resource] |> Jason.encode!

    %{conv | status: 200, resp_body: resources}
  end
end
