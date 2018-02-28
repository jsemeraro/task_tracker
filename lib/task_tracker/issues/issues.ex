defmodule TaskTracker.Issues do
  @moduledoc """
  The Issues context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.Issues.Task

  use Timex

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias TaskTracker.Issues.TimeBlock

  @doc """
  Returns the list of time_blocks.

  ## Examples

      iex> list_time_blocks()
      [%TimeBlock{}, ...]

  """
  def list_time_blocks do
    Repo.all(TimeBlock)
  end

  @doc """
  Gets a single time_block.

  Raises `Ecto.NoResultsError` if the Time block does not exist.

  ## Examples

      iex> get_time_block!(123)
      %TimeBlock{}

      iex> get_time_block!(456)
      ** (Ecto.NoResultsError)

    """
  # gets a time block by a specific id
  def get_time_block!(id), do: Repo.get!(TimeBlock, id)
  def get_time_block(id), do: Repo.get(TimeBlock, id)

  # returns all time blocks that belong to a task_id
  def get_all_time_blocks(task_id) do
    Repo.all(from t in TimeBlock, where: t.task_id == ^task_id)
  end

  # get the next end time that is nil
  def next_end_time(task_id) do
    Repo.one(from t in TimeBlock, 
      where: t.task_id == ^task_id and is_nil(t.end_time))
  end

  # determine if you should show the end button or not
  def show_end_btn(task_id) do
    x = next_end_time(task_id)
    if x == nil do
      false
    else
      true
    end
  end

  def convert_time(time) do
    if is_nil(time) do 
      "Unset"
    else
      hr = to_string(DateTime.to_time(Timex.Timezone.convert(time, "America/New_York")).hour)
      if String.length(hr) < 2 do
        hr = "0"<>hr
      end

      min = to_string(DateTime.to_time(Timex.Timezone.convert(time, "America/New_York")).minute)
      hr <> ":" <> min
    end
  end

  def convert_datetime(time) do
    if is_nil(time) do
      "Unset"
    else
      DateTime.to_string(time)
    end
  end


  @doc """
  Creates a time_block.

  ## Examples

      iex> create_time_block(%{field: value})
      {:ok, %TimeBlock{}}

      iex> create_time_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

    """
  def create_time_block(task_id) do
    start = DateTime.utc_now()
    attrs = %{start_time: start, end_time: nil, task_id: task_id}
    %TimeBlock{}
    |> TimeBlock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time_block.

  ## Examples

      iex> update_time_block(time_block, %{field: new_value})
      {:ok, %TimeBlock{}}

      iex> update_time_block(time_block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time_block(%TimeBlock{} = time_block) do
    end_time = DateTime.utc_now()
    attrs = %{start_time: time_block.start_time, end_time: end_time, task_id: time_block.task_id}

    time_block
    |> TimeBlock.changeset(attrs)
    |> Repo.update()
  end

  def edit_time_block(%TimeBlock{} = time_block, start_time, end_time) do
    IO.inspect(start_time)
    start_time = DateTime.from_unix(elem(Integer.parse(start_time), 0))
    end_time = DateTime.from_unix(elem(Integer.parse(end_time),0))

    attrs = %{start_time: start_time, end_time: end_time, task_id: time_block.task_id}

    time_block
    |> TimeBlock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TimeBlock.

  ## Examples

      iex> delete_time_block(time_block)
      {:ok, %TimeBlock{}}

      iex> delete_time_block(time_block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time_block(%TimeBlock{} = time_block) do
    Repo.delete(time_block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time_block changes.

  ## Examples

      iex> change_time_block(time_block)
      %Ecto.Changeset{source: %TimeBlock{}}

  """
  def change_time_block(%TimeBlock{} = time_block) do
    TimeBlock.changeset(time_block, %{})
  end
end
