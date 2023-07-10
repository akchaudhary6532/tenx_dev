defmodule TenExTakeHome.Helpers.ExternalApiHelper do
  @moduledoc """
  Wrapper around Http service (HTTPoison)
  """

  @spec get(String.t(), keyword(), keyword(), keyword()) ::
          {integer(), map()}
  def get(url, query_params \\ [], header \\ [], options \\ []) do
    maybe_append_query_params(url, query_params)
    |> HTTPoison.get(header, options ++ [timeout: 5000])
    |> process_response()
  end

  defp maybe_append_query_params(url, []), do: url

  defp maybe_append_query_params(url, query_params) do
    query_list =
      Enum.reduce(query_params, [], fn
        {key, value}, [] ->
          [key, "=", value]

        {key, value}, acc ->
          acc ++ ["&", key, "=", value]
      end)

    "#{url}?" <> Enum.join(query_list)
  end

  defp process_response(response) do
    case response do
      {:ok,
       %HTTPoison.Response{
         status_code: status_code,
         body: response,
         headers: _headers
       }} ->
        {status_code, Poison.decode!(response)}

      {:error, %HTTPoison.Error{id: _id, reason: reason}} ->
        {500, reason}
    end
  end
end
