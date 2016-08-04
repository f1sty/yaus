defmodule Yaus.Short.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    child = [
      worker(Yaus.Short, [Yaus.Short])
    ]

    supervise(child, strategy: :one_for_one)
  end
end
