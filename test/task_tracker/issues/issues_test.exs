defmodule TaskTracker.IssuesTest do
  use TaskTracker.DataCase

  alias TaskTracker.Issues

  describe "tasks" do
    alias TaskTracker.Issues.Task

    @valid_attrs %{complete: true, description: "some description", title: "some title", work_time: 42}
    @update_attrs %{complete: false, description: "some updated description", title: "some updated title", work_time: 43}
    @invalid_attrs %{complete: nil, description: nil, title: nil, work_time: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issues.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Issues.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Issues.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Issues.create_task(@valid_attrs)
      assert task.complete == true
      assert task.description == "some description"
      assert task.title == "some title"
      assert task.work_time == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Issues.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.complete == false
      assert task.description == "some updated description"
      assert task.title == "some updated title"
      assert task.work_time == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_task(task, @invalid_attrs)
      assert task == Issues.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Issues.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Issues.change_task(task)
    end
  end
end
