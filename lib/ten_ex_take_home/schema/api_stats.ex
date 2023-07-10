defmodule TenExTakeHome.Schema.ApiStats do
  @moduledoc """
  Schema file to store API stats
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias TenExTakeHome.Repo

  @type arg :: %{required(:url) => String.t(), required(:status_code) => integer()}
  @type t :: %__MODULE__{}

  schema "apistats" do
    field :url, :string
    field :status_code, :integer
    timestamps()
  end

  @fields ~w(url status_code)a

  @spec new(arg()) :: t()
  def new(attrs), do: %__MODULE__{} |> changeset(attrs) |> Repo.insert()

  @spec changeset(Ecto.Changeset.t() | t(), arg()) :: Ecto.Changeset.t()
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
