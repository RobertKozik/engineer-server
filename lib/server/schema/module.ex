defmodule Server.Module do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modules" do
    field :name, :string
    field :serial_id, :string

    has_one :config, Server.Config
    many_to_many :users, Server.User, join_through: Server.UserModule
    has_many :stats, Server.StatEntry
    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:name, :serial_id])
    |> validate_required([:serial_id, :name])
  end

  def update_changeset(module, attrs) do
    module
    |> cast(attrs, [:name])
  end
end
