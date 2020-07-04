defmodule Servy.ProgrammingLanguages do
  alias Servy.ProgrammingLanguages.Language

  def list_languages() do
    [
      %Language{id: 1, name: "Elixir", type: "Functional", learning: true},
      %Language{id: 2, name: "Ruby", type: "Object Oriented", learning: false},
      %Language{id: 3, name: "JavaScript", type: "Object Oriented", learning: false},
      %Language{id: 4, name: "Rust", type: "Multi Paradigm", learning: false},
    ]
  end

  def get_language(id) when is_integer(id) do
    list_languages() |> Enum.find(fn(l) -> l.id == id end)
  end

  def get_language(id) when is_binary(id) do
    list_languages() |> Enum.find(fn(l) -> l.id == id end)
  end
end
