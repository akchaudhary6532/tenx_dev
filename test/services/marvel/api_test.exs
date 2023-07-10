defmodule TenExTakeHome.Services.Marvel.ApiTest do
  import Mox

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use TenExTakeHome.DataCase, async: true

  alias TenExTakeHome.Services.Marvel.Api
  alias TenExTakeHome.Services.Marvel.Http

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    %{config: Api.config() |> Map.put(:module, Http)}
  end

  setup :verify_on_exit!

  describe "fetch_character_names/3" do
    test "Test successfull fetch", %{config: config} do
      # given
      use_cassette "marvel_api_success" do
        # then
        assert {:ok, %{limit: 20, offset: 0, names: names}} =
                 Api.fetch_character_names(config, 20, 0)

        Enum.each(names, fn name ->
          assert is_bitstring(name)
        end)
      end
    end

    test "Test failure in fetch", %{config: config} do
      # given
      use_cassette "marvel_api_failure" do
        # then
        assert {:error,
                %{
                  "code" => "InvalidCredentials",
                  "message" => "That hash, timestamp and key combination is invalid."
                }} = Api.fetch_character_names(config, 20, 0)
      end
    end
  end
end
