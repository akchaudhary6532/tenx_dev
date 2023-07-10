defmodule TenExTakeHome.Services.Marvel.HttpTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use TenExTakeHome.DataCase, async: true

  alias TenExTakeHome.Services.Marvel.Api
  alias TenExTakeHome.Services.Marvel.Http

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")

    %{config: Api.config()}
  end

  describe "Test Marvel API end to end => fetch_character_names/3" do
    test "success when valid token", %{config: config} do
      use_cassette "marvel_api_success" do
        assert {:ok, %{"limit" => 20, "offset" => 0, "results" => results}} =
                 Http.fetch_character_names(config, 20, 0)

        assert length(results) == 20
      end
    end

    test "failure when invalid token", %{config: config} do
      use_cassette "marvel_api_failure" do
        config = Map.put(config, :private_key, nil)

        assert {:error, %{"code" => "InvalidCredentials"}} =
                 Http.fetch_character_names(config, 20, 0)

      end
    end
  end
end
