defmodule Realtime.Warehouse.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :product_name, :string
    field :product_code, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:product_name, :product_code])
    |> validate_required([:product_name, :product_code])
    |> validate_length(:product_name, min: 2, max: 100)
    |> validate_length(:product_code, min: 2, max: 30)
  end
end
