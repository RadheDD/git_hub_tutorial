defmodule GitHubTutorial1.Repo do
  use Ecto.Repo,
    otp_app: :git_hub_tutorial_1,
    adapter: Ecto.Adapters.Postgres
end
