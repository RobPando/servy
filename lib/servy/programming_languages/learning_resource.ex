defmodule Servy.ProgrammingLanguages.LearningResource do
  @doc """
    Simulates fetching learning resources of a particular programming languages
    and compiling it into a pdf.
  """
  def get_resource(language) do
    # Simulate 1 second of fetching and compiling.
    :timer.sleep(1000)

    # Example of return file name
    "#{language}-resources.pdf"
  end
end
