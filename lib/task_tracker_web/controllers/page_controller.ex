defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    tasks = TaskTracker.Issues.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end
end
