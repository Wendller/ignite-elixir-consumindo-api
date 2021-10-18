defmodule TeslaChallengeWeb.Auth.Guardian do
  use Guardian, otp_app: :tesla_challenge

  alias TeslaChallenge.Repo
  alias TeslaChallenge.Error
  alias TeslaChallenge.Users.User

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Repo.get(User, id)

    {:ok, user}
  end

  def authenticate(%{"id" => user_id, "password" => password} = _params) do
    with %User{password_hash: password_hash} = user <- Repo.get(User, user_id),
         true <- Pbkdf2.verify_pass(password, password_hash),
         {:ok, token, _claims} <-
           encode_and_sign(
             user,
             %{},
             ttl: {1, :minute},
             token_type: "refresh"
           ) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
