defmodule CowboyTutorial.Repo.Migrations.CrateUsersTable do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string

      timestamps()
    end

    create unique_index :users, [:name], concurrently: true
    create unique_index :users, [:email], concurrently: true
  end
end
