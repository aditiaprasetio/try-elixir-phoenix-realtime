defmodule Realtime.WarehouseTest do
  use Realtime.DataCase

  alias Realtime.Warehouse

  describe "products" do
    alias Realtime.Warehouse.Product

    import Realtime.WarehouseFixtures

    @invalid_attrs %{product_name: nil}
    @invalid_attrs %{product_code: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Warehouse.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Warehouse.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{product_name: "some product_name"}
      valid_attrs = %{product_code: "TESTCODE"}

      assert {:ok, %Product{} = product} = Warehouse.create_product(valid_attrs)
      assert product.product_name == "some product_name"
      assert product.product_code == "TESTCODE"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{product_name: "some updated product_name"}
      update_attrs = %{product_code: "TESTCODE1"}

      assert {:ok, %Product{} = product} = Warehouse.update_product(product, update_attrs)
      assert product.product_name == "some updated product_name"
      assert product.product_code == "TESTCODE1"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_product(product, @invalid_attrs)
      assert product == Warehouse.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Warehouse.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_product(product)
    end
  end
end
