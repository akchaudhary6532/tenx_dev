defmodule TenExTakeHome.Services.Marvel.Api do
  @moduledoc """
  Interface for services to use MarvelApi.
  It implements Marvel.Behaviour and process the response from HTTP.
  It can be mocked with `:marvel_module` config in test.exs
  """
  alias TenExTakeHome.Services.Marvel.Behaviour
  alias TenExTakeHome.Services.Marvel.Http

  def config() do
    config = Application.get_env(:ten_ex_take_home, __MODULE__, [])

    %{
      base_url: Keyword.fetch!(config, :base_url),
      private_key: Keyword.fetch!(config, :private_key),
      public_key: Keyword.fetch!(config, :public_key),
      module: Keyword.get(config, :marvel_module, Http)
    }
  end

  @spec fetch_character_names(map(), integer(), integer()) ::  {:ok, Behaviour.character_names_obj()} | {:error, String.t()}
  def fetch_character_names(config, limit, offset) do
    with {:ok, data} <- config.module.fetch_character_names(config, limit, offset) do
      {:ok, transform_fetch_character_names(data)}
    end
  end

  defp transform_fetch_character_names(data) do
   names =  Enum.map(data["results"], & &1["name"])

    %{
      names: names,
      limit: data["limit"],
      offset: data["offset"]
    }
  end
end
