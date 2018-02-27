defmodule TaskTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Accounts.User
  alias TaskTracker.Accounts.Manager

  schema "users" do
    field :email, :string
    field :name, :string

    has_many :managers_managing, Manager, foreign_key: :manager_id
    has_many :underling_under, Manager, foreign_key: :underling_id
    has_many :managers, through: [:managers_managing, :manager]
    has_many :underlings, through: [:underling_under, :underling]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
