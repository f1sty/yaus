defmodule Yaus.Short do
  @moduledoc false

  use GenServer

  # APIs
  def start_link(initial) do
    GenServer.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def hash_url(url, uid) do
    GenServer.call(__MODULE__, {:hash_url, url, uid})
  end

  # Callbacks
  def handle_call({:hash_url, url, uid}, _from, _state) do
    link_id = url 
    |> Murmur.hash_x86_32(uid) 
    |> to_string
    {:reply, link_id, link_id}
  end
end
