defmodule Servy.GenericServer do
  def start(callback_module, initial_state, name) do
    pid = spawn(__MODULE__, :listen_loop, [initial_state, callback_module])
    Process.register(pid, name)
    pid
  end

  def call(pid, message) do
    send pid, {:call, self(), message}

    receive do
      {:response, response} -> response
    end
  end

  def cast(pid, message) do
    send pid, {:cast, message}
  end

  def listen_loop(state, callback_module) do
    receive do
      {:call, sender, message} when is_pid(sender) ->
        {response, new_state} = callback_module.handle_call(message, state)
        send sender, {:response, response}
        listen_loop(new_state, callback_module)
      {:cast, message} ->
        new_state = callback_module.handle_cast(message, state)
        listen_loop(new_state, callback_module)
      unexpected ->
        IO.puts "Invalid message: #{inspect unexpected}"
        listen_loop(state, callback_module)
    end
  end
end

defmodule Servy.DonationServerWheelReinvented do
  alias Servy.GenericServer

  @process_name __MODULE__

  def start do
    IO.puts "Starting donation server..."
    GenericServer.start(__MODULE__, [], @process_name)
  end

  def get_recent_donations() do
    GenericServer.call @process_name, :recent_donations
  end

  def create_donation(name, amount) do
    GenericServer.call @process_name, {:create_donation, name, amount}
  end

  def clear() do
    GenericServer.cast @process_name, :clear
  end

  # Server callbacks

  def handle_call(:recent_donations, state) do
    {state, state}
  end

  def handle_call({:create_donation, name, amount}, state) do
    {:ok, id} = send_donation_to_service(name, amount)
    recent_donations = Enum.take(state, 2)
    new_state = [{name, amount} | recent_donations]
    {id, new_state}
  end

  def handle_cast(:clear, _state) do
    []
  end

  defp send_donation_to_service(_name, _amount) do
    # Simulates sending and writing donation to external service/db

    {:ok, UUID.uuid4()}
  end
end
