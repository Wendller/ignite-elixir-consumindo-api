defmodule TeslaChallenge.Repo do
  use Ecto.Repo,
    otp_app: :tesla_challenge,
    adapter: Ecto.Adapters.Postgres
end
