defmodule Shopper.Repo.Migrations.CreateStoresTable do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :post_code_id, references(:postcodes)
      add :store_open_date, :date
    end
  end
end
