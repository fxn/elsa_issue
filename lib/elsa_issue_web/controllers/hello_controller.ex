defmodule ElsaIssueWeb.HelloController do
  use ElsaIssueWeb, :controller

  def index(conn, _params) do
    response =
      Elsa.produce(
        :elsa_issue,
        "elsa-issue",
        message()
      )

    json(conn, %{"response" => inspect(response)})
  end

  defp message do
    DateTime.utc_now() |> DateTime.to_string()
  end
end
