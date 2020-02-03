defmodule ElsaIssueWeb.HelloControllerTest do
  use ElsaIssueWeb.ConnCase
  import ElsaIssue.TestHelper

  describe "produces and consumes events" do
    setup do
      IO.puts("Start setup")

      mhref = make_ref()
      state = {self(), mhref}
      start_supervised(events_consumer_childspec(state))

      IO.puts("End setup")

      [mhref: mhref]
    end

    test "test 1", %{conn: conn, mhref: mhref} do
      IO.puts("Start test 1")

      get(conn, Routes.hello_path(conn, :index))
      assert_receive {^mhref, _timestamp}

      IO.puts("End test 1")
    end
  end

  describe "produces, but does not consume events" do
    test "test 2", %{conn: conn} do
      IO.puts("Start test 2")

      get(conn, Routes.hello_path(conn, :index))

      IO.puts("End test 2")
    end
  end
end
