defmodule RealtimeWeb.ProductLive.Index do
  use RealtimeWeb, :live_view

  alias Realtime.Warehouse
  alias Realtime.Warehouse.Product
  alias Phoenix.Socket.Broadcast

  @topic "products"

  @impl true
  def mount(_params, _session, socket) do
    RealtimeWeb.Endpoint.subscribe(@topic)
    {:ok, stream(socket, :products, Warehouse.list_products())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Warehouse.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_info({RealtimeWeb.ProductLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, stream_insert(socket, :products, product)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Warehouse.get_product!(id)
    {:ok, _} = Warehouse.delete_product(product)

    {:ok, _} = RealtimeWeb.Endpoint.broadcast_from!(self(), @topic, "product_deleted", product)
    # RealtimeWeb.Endpoint.broadcast_from!(self(), "room:superadmin", "new_msg", %{uid: uid, body: body})

    {:noreply, stream_delete(socket, :products, product)}
  end

  @impl true
  def handle_info(%Broadcast{topic: _, event: _event, payload: _product}, socket) do
    {:ok, stream(socket, :products, Warehouse.list_products())}
    # {:noreply, update(socket, :products, fn products -> [product | products] end)}

    # {:ok, _} ->
    #   socket = update(socket, :products, fn products -> &Enum.reject(&1.id == product.id) end)
    #   {:noreply, socket}

    # {:error, _} ->
    #   {:noreply, socket}
  end
end
