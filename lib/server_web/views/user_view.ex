defmodule ServerWeb.UserView do
  use ServerWeb, :view

  def render("index.json", %{users: users}) do
    %{
      data:
        Enum.map(users, fn user ->
          %{email: user.email, name: user.name, password: user.password}
        end)
    }
  end

  def render("create.json", %{user: user}) do
    %{data: %{email: user.email, name: user.name, password: user.password}}
  end
end
