defmodule TenExTakeHomeWeb.ComicsControllerTest do
  use TenExTakeHomeWeb.ConnCase

  import Mox

  setup :verify_on_exit!

  describe "GET /" do
    test "when successful fetch check entries on UI", %{conn: conn} do
      # given
      characters = characters()
      mock_marvel_api_success(characters)

      # when
      result = conn |> get(~p"/") |> html_response(200)

      # then
      assert result =~ "Page: 1"
      refute result =~ "| Next"

      for %{"name" => name} <- characters do
        assert result =~ name
      end
    end

    test "when token error check error message in flash", %{conn: conn} do
      # given
      mock_marvel_api_failure()

      # when
      result = conn |> get(~p"/") |> get_flash(:info)

      # then
      assert result =~ "The hash, timestamp and key combination is invalid."
    end
  end

  defp characters() do
    for _ <- 1..10, do: %{"name" => Faker.Superhero.name()}
  end

  defp mock_marvel_api_success(characters) do
    expect(MarvelApiMock, :fetch_character_names, fn _, _, _ ->
      map = %{
        "results" => characters,
        "limit" => length(characters),
        "offset" => 0,
        "total" => length(characters)
      }

      {:ok, map}
    end)
  end

  defp mock_marvel_api_failure() do
    expect(MarvelApiMock, :fetch_character_names, fn _, _, _ ->
      {:error,
       %{
         "code" => "InvalidCredentials",
         "message" => "The hash, timestamp and key combination is invalid."
       }}
    end)
  end
end
