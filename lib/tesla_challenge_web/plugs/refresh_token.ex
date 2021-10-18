defmodule TeslaChallengeWeb.Plugs.RefreshToken do
  import Plug.Conn

  alias TeslaChallengeWeb.Auth.Guardian
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{} = conn, _options) do
    ["Bearer " <> token] = get_req_header(conn, "authorization")

    with {:ok, _old_stuff, {new_token, _new_claims}} <- Guardian.refresh(token, ttl: {1, :minute}) do
      put_req_header(conn, "authorization", "Bearer #{new_token}")

      conn
    else
      _error -> render_error(conn)
    end
  end

  def call(conn, _options), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{message: "Expired token"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
