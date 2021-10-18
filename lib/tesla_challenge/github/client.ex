defmodule Github.Client do
  use Tesla

  alias TeslaChallenge.Error

  @base_url "https://api.github.com/users/"

  plug Tesla.Middleware.Headers, [{"User-Agent", "banana"}]
  plug Tesla.Middleware.JSON

  def get_user_repos(url \\ @base_url, user) do
    "#{url}#{user}/repos"
    |> get()
    |> handle_repos()
  end

  defp handle_repos({:ok, %Tesla.Env{status: 200, body: body}}) do
    Enum.map(body, fn %{
                        "id" => id,
                        "name" => name,
                        "description" => description,
                        "html_url" => html_url,
                        "stargazers_count" => stargazers_count
                      } = repo ->
      %{
        id: id,
        name: name,
        description: description,
        html_url: html_url,
        stargazers_count: stargazers_count
      }
    end)
  end
end
