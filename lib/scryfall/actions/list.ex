defmodule Scryfall.Actions.List do
  defmacro __using__(_opts) do
    quote do
      import Scryfall.Actions.List
      import Scryfall.Record

      def list, do: list([])
    end
  end
end
