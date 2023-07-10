# Define MarvelApi mock
Mox.defmock(MarvelApiMock, for: TenExTakeHome.Services.Marvel.Behaviour)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TenExTakeHome.Repo, :manual)
