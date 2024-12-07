defmodule GitHubTutorial1.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GitHubTutorial1Web.Telemetry,
      GitHubTutorial1.Repo,
      {DNSCluster, query: Application.get_env(:git_hub_tutorial_1, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GitHubTutorial1.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GitHubTutorial1.Finch},
      # Start a worker by calling: GitHubTutorial1.Worker.start_link(arg)
      # {GitHubTutorial1.Worker, arg},
      # Start to serve requests, typically the last entry
      GitHubTutorial1Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GitHubTutorial1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GitHubTutorial1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
