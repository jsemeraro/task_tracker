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

  describe "time_blocks" do
    alias TaskTracker.Issues.TimeBlock

    @valid_attrs %{end_time: ~N[2010-04-17 14:00:00.000000], start_time: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end_time: ~N[2011-05-18 15:01:01.000000], start_time: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issues.create_time_block()

      time_block
    end

    test "list_time_blocks/0 returns all time_blocks" do
      time_block = time_block_fixture()
      assert Issues.list_time_blocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Issues.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Issues.create_time_block(@valid_attrs)
      assert time_block.end_time == ~N[2010-04-17 14:00:00.000000]
      assert time_block.start_time == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Issues.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.end_time == ~N[2011-05-18 15:01:01.000000]
      assert time_block.start_time == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_time_block(time_block, @invalid_attrs)
      assert time_block == Issues.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Issues.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Issues.change_time_block(time_block)
    end
  end
end
