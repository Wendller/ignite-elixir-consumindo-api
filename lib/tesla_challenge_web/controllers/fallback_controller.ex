defmodule TeslaChallengeWeb.FallbackController do
  use TeslaChallengeWeb, :controller

  alias TeslaChallenge.Error
  alias TeslaChallengeWeb.ErrorView

  def call(connection, {:error, %Error{status: status, result: result}}) do
    connection
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
