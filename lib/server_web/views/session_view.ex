defmodule ServerWeb.SessionView do
  use ServerWeb, :view

  def render("new.json", %{token: token}) do
    %{token: token}
  end

  def render("create.json", %{user: user}) do
    %{data: %{email: user.email, name: user.name}}
  end

end
