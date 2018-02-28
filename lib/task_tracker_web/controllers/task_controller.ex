defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Issues
  alias TaskTracker.Issues.Task
  alias TaskTracker.Accounts

  def index(conn, _params) do
    tasks = Issues.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Issues.change_task(%Task{})
    curr_user = conn.assigns[:current_user].id
    users = Accounts.underlings_users(curr_user)
    render(conn, "new.html", changeset: changeset, users: users, curr_user: curr_user)
  end
  
  def create(conn, %{"task" => task_params}) do
    case Issues.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Issues.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def show_ndrlng(conn, _params) do
    curr_user = conn.assigns[:current_user].id
    ndrlngs = TaskTracker.Accounts.underlings_users(curr_user)
    tasks = Enum.map(ndrlngs, fn(underlings)-> 
      all_tasks = Issues.list_tasks()
      Enum.map(all_tasks, fn (t) ->
        if t.user_id == underlings.id do
          t
        end
      end)
    end)
    render(conn, "show_ndrlng.html", tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    task = Issues.get_task!(id)
    changeset = Issues.change_task(task)
    users = Accounts.list_users()
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Issues.get_task!(id)
    users = Accounts.list_users()
    case Issues.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Issues.get_task!(id)
    {:ok, _task} = Issues.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
