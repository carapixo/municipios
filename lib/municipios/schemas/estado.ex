defmodule Municipios.Schema.Estado do
  use Ecto.Schema
  import Ecto.Changeset

  schema "estados" do
    field :nome, :string
    field :sigla, :string

    has_many(:municipios, Municipios.Schema.Municipio)

    timestamps()
  end

  @required_params [:nome, :sigla]
  @optional_params []

  def changeset(estado, attrs) do
    estado
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
    |> unique_constraint(:sigla)
  end
end
