defmodule ServerWeb.UserController do
    use ServerWeb, :controller

    alias Server.{Repo, User}

    def index(conn, _params) do
        users = Repo.all(User)
        render(conn, "index.json", users: users)
    end

    def create(conn, %{"email" => email_, "name" => name_, "password" => password_}) do
        user = %User{email: email_, name: name_, password: password_}
        {_, struct} = Repo.insert user
        render(conn, "create.json", user: user)
    end 

end