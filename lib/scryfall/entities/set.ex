defmodule Scryfall.Entity.Set do
  use Scryfall.Actions

  def list(params) when is_map(params), do: get(params, "sets")

  def get(id) when is_binary(id), do: get("sets/#{id}")

  def foo do
  end
end
