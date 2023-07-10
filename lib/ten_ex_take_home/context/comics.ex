defmodule TenExTakeHome.Context.Comics do
  use Nebulex.Caching.Decorators

  alias TenExTakeHome.Services.Marvel.Api
  alias TenExTakeHome.Cache

  @limit 20
  @ttl :timer.hours(24) * 30

  @decorate cacheable(cache: Cache, opts: [ttl: @ttl])
  @spec get_marvel_character_names(integer()) :: {:ok, map()} | {:error, map()}
  def get_marvel_character_names(page) do
    offset = (page - 1) * @limit
    Api.fetch_character_names(Api.config(), @limit, offset)
  end
end
