defmodule ElsaIssue.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      ElsaIssueWeb.Endpoint,
      {
        Elsa.Supervisor,
        [
          endpoints: [kafka: 9092],
          connection: :elsa_issue,
          producer: [topic: "elsa-issue"]
        ]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElsaIssue.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElsaIssueWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
