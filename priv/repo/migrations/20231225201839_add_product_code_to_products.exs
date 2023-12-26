defmodule Realtime.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :product_code, :string
    end
  end
end
