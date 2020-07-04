defmodule Servy.Conv do
  defstruct method: "",
            path: "",
            headers: %{},
            params: %{},
            resp_content_type: "text/html",
            resp_body: "",
            status: nil
end
