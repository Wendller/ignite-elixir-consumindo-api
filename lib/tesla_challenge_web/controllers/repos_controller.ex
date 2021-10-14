defmodule TeslaChallengeWeb.ReposController do
  use TeslaChallengeWeb, :controller

  alias Github.Client
  alias TeslaChallengeWeb.FallbackController

  action_fallback FallbackController

  def show(connection, %{"user" => user} = params) do
    with [head | _tail] = repos <- Client.get_user_repos(user) do
      connection
      |> put_status(:ok)
      |> json(%{
        success: repos
      })
    end
  end
end
