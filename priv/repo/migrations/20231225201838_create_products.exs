defmodule Realtime.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :product_name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
