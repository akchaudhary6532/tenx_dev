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

  @doc """
  Fetches lists of comic characters
  """
  @spec fetch_character_names(map(), integer(), integer()) ::  {:ok, Behaviour.character_names_obj()} | {:error, map()}
  def fetch_character_names(config, limit, offset) do
    with {:valid, true} <- {:valid, validate_limit_and_offset(limit, offset)},
    {:ok, data} <- config.module.fetch_character_names(config, limit, offset) do
      {:ok, transform_fetch_character_names(data)}
    else
      {:valid, false} -> {:error, %{"code" => "NegativePage", "message" => "Limit must be > 0 and offset >= 0"}}
      error -> error
    end
  end

  defp transform_fetch_character_names(data) do
   names =  Enum.map(data["results"], & &1["name"])

    %{
      names: names,
      limit: data["limit"],
      offset: data["offset"],
      total: data["total"],
      total_pages: ceil(data["total"] / data["limit"]),
      page: div(data["offset"], data["limit"]) + 1
    }
  end

  defp validate_limit_and_offset(limit, offset), do: limit > 0 and offset >= 0
end
