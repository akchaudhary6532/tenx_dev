defmodule TenExTakeHome.Repo.Migrations.Apistats do
  use Ecto.Migration

  def change do
    create table(:apistats) do
      add :url, :string
      add :status_code, :integer
      timestamps()
    end

    create index(:apistats, [:url])
    create index(:apistats, [:status_code])
  end
end
