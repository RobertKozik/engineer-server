defmodule Server.UserModule do

  use Ecto.Schema
  import Ecto.Changeset

  alias Server.{User, Module}

  @primary_key false
  schema "users_modules" do
    belongs_to(:user, User, primary_key: true)
    belongs_to(:module, Module, primary_key: true)
  end

  def changeset(users_modules, params \\ %{}) do
    users_modules
    |> foreign_key_constraint(:module_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:user, :module])
  end
end
