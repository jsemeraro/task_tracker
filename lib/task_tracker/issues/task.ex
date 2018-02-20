defmodule TaskTracker.Issues.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Issues.Task


  schema "tasks" do
    belongs_to :user, TaskTracker.Accounts.User
    field :complete, :boolean, default: false
    field :description, :string
    field :title, :string
    field :work_time, :integer

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :complete, :work_time, :user_id])
    |> validate_required([:title, :description, :complete, :work_time, :user_id])
  end
end