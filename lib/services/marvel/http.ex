defmodule TenExTakeHome.Services.Marvel.Http do
  @moduledoc """
  Module handeling API calls to MarvelApis
  """
  alias TenExTakeHome.Helpers.ExternalApiHelper
  alias TenExTakeHome.Schema.ApiStats

  @behaviour TenExTakeHome.Services.Marvel.Behaviour
  @characters_url "/characters"

  @impl true
  def fetch_character_names(config, limit, offset) do
    query_params = get_auth_token(config)

    {status, data} =
      ExternalApiHelper.get(
        config.base_url <> @characters_url,
        query_params ++ [limit: limit, offset: offset]
      )

    if status == 200 do
      ApiStats.new(%{url: @characters_url, status_code: 200})
      {:ok, data["data"]}
    else
      {:error, data}
    end
  end

  defp now_to_epoch do
    {mega, sec, micro_sec} = :os.timestamp()
    mega * 1000 * 1000 * 1000 + sec * 1000 + div(micro_sec, 1000)
  end

  def get_auth_token(config) do
    ts = now_to_epoch()

    key = Enum.join([ts, config.private_key, config.public_key], "")
    md5 = :crypto.hash(:md5, key) |> Base.encode16(case: :lower)

    [ts: to_string(ts), hash: md5, apikey: config.public_key]
  end
end
