defmodule HandlerTest do
  use ExUnit.Case
  doctest Servy

  alias Servy.Handler

  test "GET /languages" do
    request = """
    GET /languages HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
    response = Servy.Handler.handle(request)
    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 185

    <h1>Programming Languages</h1>
    <ul>

      <li>Elixir - Functional</li>

      <li>Ruby - Object Oriented</li>

      <li>JavaScript - Object Oriented</li>

      <li>Rust - Multi Paradigm</li>

    </ul>

    """
    assert response == expected_response
  end

  test "GET /todo" do
    request = """
    GET /todo HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
    response = Servy.Handler.handle(request)
    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 80

    <h1>Todo</h1>
    <ul>
      <li>Learn</li>
      <li>Create</li>
      <li>Innovate</li>
    </ul>

    """
    assert response == expected_response
  end

  test "GET /api/v1/languages" do
    request = """
    GET /api/v1/languages HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
    response = Servy.Handler.handle(request)
    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 262

    [{\"id\":1,\"learning\":true,\"name\":\"Elixir\",\"type\":\"Functional\"},{\"id\":2,\"learning\":false,\"name\":\"Ruby\",\"type\":\"Object Oriented\"},{\"id\":3,\"learning\":false,\"name\":\"JavaScript\",\"type\":\"Object Oriented\"},{\"id\":4,\"learning\":false,\"name\":\"Rust\",\"type\":\"Multi Paradigm\"}]
    """
    assert response == expected_response
  end

  test "GET /language/:id" do
    request = """
    GET /language/1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
    response = Servy.Handler.handle(request)
    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 25

    <h1>Language Elixir</h1>

    """
    assert response == expected_response
  end

  test "POST /languages" do
    language_to_create = "Crystal"
    request = """
    POST /languages HTTP/1.1
    Host: example.com
    Content-Type: application/x-www-form-urlencoded
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    name=#{language_to_create}
    """
    response = Servy.Handler.handle(request)
    expected_response = """
    HTTP/1.1 201 Created
    Content-Type: text/html
    Content-Length: 45

    Programming Language #{language_to_create} has been created
    """
    assert response == expected_response
  end

  test "GET /learning_resources" do
    request = """
    GET /learning_resources HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
    response = Servy.Handler.handle(request)
    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 66

    [\"elixir-resources.pdf\",\"ruby-resources.pdf\",\"rust-resources.pdf\"]
    """
    assert response == expected_response
  end

  test "GET /fake_route" do
    request = """
    GET /fake_route HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
    response = Servy.Handler.handle(request)
    expected_response = """
    HTTP/1.1 404 Not Found
    Content-Type: text/html
    Content-Length: 28

    no route matches /fake_route
    """
    assert response == expected_response
  end
end
