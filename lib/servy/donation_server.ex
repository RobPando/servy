defmodule Servy.DonationServer do
  use GenServer

  alias Servy.DonationCache

  @process_name __MODULE__

  def start do
    IO.puts "Starting donation server..."
    GenServer.start(__MODULE__, %DonationCache{}, name: @process_name)
  end

  def get_recent_donations() do
    GenServer.call @process_name, :recent_donations
  end

  def create_donation(name, amount) do
    GenServer.call @process_name, {:create_donation, name, amount}
  end

  def clear() do
    GenServer.cast @process_name, :clear
  end

  # Server callbacks

  def init(state) do
    recent_donations = fetch_recent_donations_from_service()
    new_state = %{state | donations: recent_donations}
    {:ok, new_state}
  end

  def handle_call(:recent_donations, _from, state) do
    {:reply, state.donations, state}
  end

  def handle_call({:create_donation, name, amount}, _from, state) do
    {:ok, id} = send_donation_to_service(name, amount)
    recent_donations = Enum.take(state.donations, 2)
    new_donations = [{name, amount} | recent_donations]
    new_state = %{state | donations: new_donations}
    {:reply, id, new_state}
  end

  def handle_cast(:clear, state) do
    {:noreply, %{state | donations: []}}
  end

  def handle_info(message, state) do
    IO.puts "Invalid message: #{inspect message}"
    {:noreply, state}
  end

  # External service functions

  defp send_donation_to_service(_name, _amount) do
    # Simulates sending and writing donation to external service/db

    {:ok, UUID.uuid4()}
  end

  defp fetch_recent_donations_from_service() do
    [{"Homer", "20"}, {"Bart", "5"}]
  end
end
