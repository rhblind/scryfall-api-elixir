ExUnit.start()
Application.ensure_all_started(:bypass)

defmodule Scryfall.TestHelper do
  defmodule Fixture do
    def read(filename) do
      File.read!("test/fixtures/#{filename}")
    end
  end
end
