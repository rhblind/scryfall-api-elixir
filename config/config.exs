use Mix.Config
import_config("#{Mix.env()}.exs")

config(:scryfall, :base_uri, "https://api.scryfall.com")
