defmodule TenExTakeHome.Services.Marvel.Behaviour do
  @type character_names_obj :: %{
           required(:names) => list(String.t()),
           required(:limit) => integer(),
           required(:offset) => integer()
         }

  @callback fetch_character_names(map(), integer(), integer()) ::
              {:ok, character_names_obj()} | {:error, String.t()}
end
