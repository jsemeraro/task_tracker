defmodule TaskTracker.Issues.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Issues.TimeBlock
  alias TaskTracker.Issues.Task


  schema "time_blocks" do
    belongs_to :task, Task
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :end_time, :task_id])
    |> validate_required([:start_time, :task_id])
  end
end
