defmodule Scryfall.Supervisor do
	@moduledoc """
  Supervisor for the cache
  """
  use Supervisor

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      # TODO: Read Cachex start options from config
      worker(Cachex, [:scryfall_cache, []])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
