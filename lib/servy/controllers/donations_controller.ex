defmodule Servy.Controllers.DonationsController do
  alias Servy.DonationServer

  def index(conv) do
    recent_donations = DonationServer.get_recent_donations()

    %{ conv | status: 200, resp_body: (inspect recent_donations)}
  end

  def create(conv, %{ "name" => name, "amount" => amount }) do
    DonationServer.create_donation(name, String.to_integer(amount))

    %{ conv | status: 201, resp_body: "#{name} donated #{amount}" }
  end
end
