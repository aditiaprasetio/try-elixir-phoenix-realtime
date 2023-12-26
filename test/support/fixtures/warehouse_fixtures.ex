defmodule Realtime.WarehouseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Realtime.Warehouse` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        product_name: "some product_name"
      })
      |> Enum.into(%{
        product_code: "TESTCODE"
      })
      |> Realtime.Warehouse.create_product()

    product
  end
end
