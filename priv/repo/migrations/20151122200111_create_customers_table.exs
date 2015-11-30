defmodule Shopper.Repo.Migrations.CreateCustomersTable do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :customer_id, :integer, primary_key: true
      add :post_code, :string
      add :longitude, :float
      add :latitude, :float
    end
  end
end
