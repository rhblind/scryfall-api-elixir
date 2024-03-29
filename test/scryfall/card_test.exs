defmodule Scryfall.Entity.CardTest do
  use ExUnit.Case
  alias Scryfall.TestHelper.Fixture
  alias Scryfall.Entity.Card

  setup do
    bypass = Bypass.open()
    Application.put_env(:scryfall, :base_uri, "http://localhost:#{bypass.port}/")
    {:ok, bypass: bypass}
  end

  test ".list requests /cards the endpoint", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      assert "/cards" == conn.request_path
      Plug.Conn.resp(conn, 200, Fixture.read("cards.json"))
    end)

    Card.list()
  end

  test ".get request the /cards/:id endpoint", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      assert "/cards/4685e726-1ea7-4bc4-b76d-d815ce5b1804"
      Plug.Conn.resp(conn, 200, Fixture.read("card.json"))
    end)

    assert %Scryfall.Record{type: "card", id: "4685e726-1ea7-4bc4-b76d-d815ce5b1804"} =
             Card.get("4685e726-1ea7-4bc4-b76d-d815ce5b1804")
  end
end
