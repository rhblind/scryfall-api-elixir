defmodule Scryfall.Client do
  defmacro __using__(_opts) do
    quote do
      import Scryfall.Client
      use HTTPoison.Base

      def request(:get, url, params) do
        case get(url, [], params: params) do
          {:ok, %HTTPoison.Response{status_code: code, headers: headers, body: body}} when code in 200..299 ->
            {:ok, body, headers}

          {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
            {:error, %{"status_code" => code, "reason" => body}}
          {:error, error} ->
            raise "Scryfall.Client.error: #{error}"
        end
      end

      def process_url(url) do
        base_uri = Application.get_env(:scryfall, :base_uri, "https://api.scryfall.com")

        Enum.join([
          String.trim_trailing(base_uri, "/"),
          "/",
          String.trim_leading(url, "/")
        ])
      end
    end
  end
end
