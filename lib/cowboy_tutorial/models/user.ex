defmodule CowboyTutorial.Models.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_digest, :string
    field :password, :string, virtual: true

    timestamps()
  end
end
