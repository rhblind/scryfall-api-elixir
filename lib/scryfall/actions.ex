defmodule Scryfall.Actions do
  defmacro __using__(opts) do
    quote do
      import Scryfall.Actions
      use Scryfall.Client

      case unquote(opts) |> Keyword.has_key?(:only) do
        true ->
          unquote(opts)
          |> Keyword.fetch!(:only)
          |> Enum.each(fn option ->
            case option do
              :get -> use Scryfall.Actions.Get
              :list -> use Scryfall.Actions.List
            end
          end)

        # use Scryfall.Actions.Self

        _ ->
          use Scryfall.Actions.Get
          use Scryfall.Actions.List
          # use Scryfall.Actions.Self
      end
    end
  end
end
