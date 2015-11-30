defmodule Shopper.Repo.Migrations.CreateStoresTable do
  use Ecto.Migration

  def change do
    create table(:stores, primary_key: false) do
      add :store_id, :integer, primary_key: true
      add :post_code, :string
      add :longitude, :float
      add :latitude, :float
      add :store_open_date, :date
    end
  end
end
