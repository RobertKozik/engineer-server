defmodule Server.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    many_to_many :modules, Server.Module, join_through: Server.UserModule
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> cast_assoc(:modules, required: false)
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:name)
    |> unique_constraint(:email)
    |> update_change(:password_hash, &Bcrypt.hash_pwd_salt/1)
  end
end
