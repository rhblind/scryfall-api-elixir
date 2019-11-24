defmodule Scryfall.Actions.Get do
  defmacro __using__(_opts) do
    quote do
      import Scryfall.Actions.Get
      import Scryfall.Record

      def get(params, url) when is_list(params) and is_binary(url), do: get(url, params)
      def get(url, params) when is_binary(url) do
        case get(url, [], params: params) do
          {:ok, %HTTPoison.Response{status_code: code, headers: headers, body: body}}
          when code in 200..299 ->
            {:ok, body, headers} |> content_type |> decode |> to_record

          {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
            {:error, %{"status_code" => code, "reason" => body}}

          {:error, error} ->
            raise "Scryfall.Client.error: #{error}"
        end
      end
    end
  end
end
