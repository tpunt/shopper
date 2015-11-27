defmodule Shopper.Repo.Migrations.CreatePostCodesTable do
  use Ecto.Migration

  def change do
    create table(:postcodes) do
      add :post_code, :string
      add :longitude, :decimal, precision: 10, scale: 7
      add :latitude, :decimal, precision: 10, scale: 7
    end
  end
end
