defmodule TeslaChallengeWeb.UsersController do
  use TeslaChallengeWeb, :controller

  alias TeslaChallenge.Users.User
  alias TeslaChallengeWeb.FallbackController
  alias TeslaChallengeWeb.Auth.Guardian

  action_fallback FallbackController

  def create(connection, params) do
    with {:ok, %User{} = user} <- TeslaChallenge.Users.Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      connection
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end

  def sign_in(connection, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      connection
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
