defmodule Scryfall.Entity.Card do
  use Scryfall.Actions

  def list, do: list([])
  def list(params) when is_list(params), do: get(params, "cards")

  def get(id) when is_binary(id), do: get("cards/#{id}", [])

  def search(params) when is_map(params), do: get(params, "cards/search")

  def named(params) when is_map(params), do: get(params, "cards/named")
end
