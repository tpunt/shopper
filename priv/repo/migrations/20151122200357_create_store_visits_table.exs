defmodule Shopper.Repo.Migrations.CreateStoreVisitsTable do
  use Ecto.Migration

  def change do
    create table(:storevisits, primary_key: false) do
      add :store_visit_id, :integer, primary_key: true
      add :customer_id, references(:customers, [column: :customer_id, type: :integer])
      add :store_id, references(:stores, [column: :store_id, type: :integer])
      add :visit_date, :date
      add :distance, :decimal, precision: 6, scale: 2
      add :distance_travelled, :decimal, precision: 6, scale: 2
      add :time_travelled, :integer
    end

    create index(:storevisits, [:customer_id, :store_id])
  end
end
