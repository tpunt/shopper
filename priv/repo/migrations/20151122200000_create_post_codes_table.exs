defmodule Shopper.Repo.Migrations.CreatePostCodesTable do
  use Ecto.Migration

  def change do
    create table(:postcodes) do
      add :post_code, :string
      add :longitude, :decimal
      add :latitude, :decimal
    end
  end
end
