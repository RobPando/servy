defmodule Servy.ProgrammingLanguages.Language do
  @derive Jason.Encoder
  defstruct id: nil, name: "", type: "", learning: false
end
