defmodule Scryfall.Client do
  defmacro __using__(_opts) do
    quote do
      import Scryfall.Client
      use HTTPoison.Base

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
