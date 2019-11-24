defmodule Scryfall.Record do
  require Logger

  defstruct [:attributes, :id, :links, :type]

  def content_type({:ok, body, headers}), do: {:ok, body, content_type(headers)}
  def content_type([]), do: "application/json"

  def content_type([{"Content-Type", value} | _]) do
    value
    |> String.split(";")
    |> List.first()
  end

  def content_type([_ | tail]), do: content_type(tail)

  def decode({:ok, body, "application/json"}), do: body |> Jason.decode!()

  def to_record(results) when is_list(results) do
    results |> Enum.map(&(&1 |> to_record))
  end

  def to_record(%{"data" => data}) when is_list(data) do
    data
    |> Enum.map(fn record ->
      %{attributes: record, links: nil, id: record["id"], type: record["object"]} |> to_record
    end)
  end

  def to_record(%{"id" => id, "object" => type} = result) do
    %{attributes: result, links: nil, id: id, type: type} |> to_record
  end

  @doc """
  Cache and return a `Scryfall.Record` struct for given data.
  """
  @spec to_record(map()) :: Scryfall.Record
  def to_record(%{:id => id, :links => links, :attributes => attrs, :type => type}) do
    case Cachex.fetch(:scryfall_cache, "#{type} #{id}", fn ->
      {:commit, %Scryfall.Record{id: id, links: links, attributes: attrs, type: type}}
        end) do
      {:ok, record} ->
        record
      {:commit, record} ->
        Logger.debug(":scryfall_cache miss, adding '#{type} #{id}' to cache.")
        record
      {:error, :no_cache} ->
        Logger.warn("#{:no_cache}: :scryfall_cache not available. Make sure to start the Scryfall.Supervisor to enable caching.")
        %Scryfall.Record{id: id, links: links, attributes: attrs, type: type}
    end
  end
end
