defmodule TenExTakeHome.Repo do
  use Ecto.Repo,
    otp_app: :ten_ex_take_home,
    adapter: Ecto.Adapters.Postgres
end
