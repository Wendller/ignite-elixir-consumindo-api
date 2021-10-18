defmodule TeslaChallengeWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :tesla_challenge

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
