defmodule Shopper.Repo.Migrations.CreateStoreVisitsTable do
  use Ecto.Migration

  def change do
    create table(:storevisits) do
      add :customer_id, references(:customers)
      add :store_id, references(:stores)
      add :visit_date, :date
      add :distance_travelled, :decimal
    end
  end
end
