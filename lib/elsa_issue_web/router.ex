defmodule ElsaIssueWeb.Router do
  use ElsaIssueWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElsaIssueWeb do
    pipe_through :api

    get "/", HelloController, :index
  end
end
