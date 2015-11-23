defmodule Shopper.Repo.Migrations.CreateCustomersTable do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :post_code_id, references(:postcodes)
    end
  end
end
