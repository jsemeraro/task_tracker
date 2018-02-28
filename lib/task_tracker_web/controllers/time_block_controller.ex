defmodule TaskTrackerWeb.TimeBlockController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Issues
  alias TaskTracker.Issues.TimeBlock

  action_fallback TaskTrackerWeb.FallbackController

  def index(conn, _params) do
    time_blocks = Issues.list_time_blocks()
    render(conn, "index.json", time_blocks: time_blocks)
  end

  # starting time
  def create(conn, %{"task_id" => task_id}) do
    with {:ok, %TimeBlock{} = time_block} <- Issues.create_time_block(task_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_block_path(conn, :show, time_block))
      |> render("show.json", time_block: time_block)
    end
  end

  # stoppig time
  def update(conn, %{"id" => id}) do
    time_block = Issues.get_time_block(id)

    with {:ok, %TimeBlock{} = time_block} <- Issues.update_time_block(time_block) do
      render(conn, "show.json", time_block: time_block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = Issues.get_time_block(id)

    with {:ok, %TimeBlock{}} <- Issues.delete_time_block(time_block) do
      send_resp(conn, :no_content, "")
    end
  end

  def edit(conn, %{"id" => id, "start_time" => start_time, "end_time" => end_time}) do
    time_block = Issues.get_time_block(id)

    with {:ok, %TimeBlock{} = time_block} <- Issues.edit_time_block(time_block, start_time, end_time) do
      render(conn, "show.json", time_block: time_block)
    end
  end
end
