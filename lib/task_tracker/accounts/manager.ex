defmodule TaskTracker.Accounts.Manager do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Accounts.Manager
  alias TaskTracker.Accounts.User

  schema "managers" do
    belongs_to :manager, User
    belongs_to :underling, User

    timestamps()
  end

  @doc false
  def changeset(%Manager{} = manager, attrs) do
    manager
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
  end
end
