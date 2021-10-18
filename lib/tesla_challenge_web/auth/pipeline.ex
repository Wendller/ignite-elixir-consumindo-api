defmodule TeslaChallengeWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :tesla_challenge

  alias TeslaChallengeWeb.Plugs.RefreshToken

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug RefreshToken
end
