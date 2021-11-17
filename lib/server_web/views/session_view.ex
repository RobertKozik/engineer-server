defmodule ServerWeb.SessionView do
  use ServerWeb, :view

  def render("new.json", %{token: token}) do
    %{token: token}
  end
end
