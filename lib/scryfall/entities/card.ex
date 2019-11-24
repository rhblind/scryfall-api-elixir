defmodule Scryfall.Entity.Card do
  use Scryfall.Actions

  def list, do: list([])
  def list(params) when is_list(params), do: get(params, "cards")

  def get(id) when is_binary(id) do
    case Cachex.get(:scryfall_cache, "card #{id}") do
      {:error, :no_cache} -> get("cards/#{id}", [])
      {:ok, nil} -> get("cards/#{id}", [])
      {:ok, record} -> record
    end
  end

  def search(params) when is_map(params), do: get(params, "cards/search")

  def named(params) when is_map(params), do: get(params, "cards/named")
end
