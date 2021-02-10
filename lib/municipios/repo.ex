defmodule Municipios.Repo do
  use Ecto.Repo,
    otp_app: :municipios,
    adapter: Ecto.Adapters.MyXQL
end
