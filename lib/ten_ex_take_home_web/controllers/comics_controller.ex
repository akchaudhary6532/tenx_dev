defmodule TenExTakeHomeWeb.ComicsController do
  use TenExTakeHomeWeb, :controller

  alias TenExTakeHome.Context.Comics

  def get(conn, params) do
    page = parse_page(params)

    case Comics.get_marvel_character_names(page) do
      {:ok, paginated_characters} ->
        render(conn, :list, data: paginated_characters)

      {:error, %{"message" => msg}} ->
        conn
        |> put_flash(:info, msg)
        |> render(:list, data: %{})
    end
  end

  defp parse_page(params) do
    {page, _} = Map.get(params, "page", "1") |> Integer.parse()
    if page > 0, do: page, else: 1
  end
end
