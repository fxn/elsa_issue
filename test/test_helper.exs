ExUnit.configure(assert_receive_timeout: 3000)
ExUnit.start()

defmodule ElsaIssue.TestHelper do
  def events_consumer_childspec(state) do
    {Elsa.Supervisor,
     endpoints: [kafka: 9092],
     connection: :elsa_issue_test,
     consumer: [
       topic: "elsa-issue",
       handler: __MODULE__.MessageHandler,
       begin_offset: :latest,
       handler_init_args: state
     ]}
  end

  defmodule MessageHandler do
    use Elsa.Consumer.MessageHandler

    def handle_messages(messages, state) do
      IO.puts("Message handler called")

      Enum.each(messages, &handle_message(&1, state))
      {:ack, state}
    end

    defp handle_message(message, {pid, mhref}) do
      send(pid, {mhref, message.value})
    end
  end
end
