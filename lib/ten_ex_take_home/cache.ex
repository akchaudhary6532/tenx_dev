defmodule TenExTakeHome.Cache do
  use Nebulex.Cache,
    otp_app: :ten_ex_take_home,
    adapter:
      Application.compile_env(:ten_ex_take_home, __MODULE__, [])
      |> Keyword.get(:adapter, NebulexRedisAdapter)
end
