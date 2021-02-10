defmodule Municipios.Schema.Municipio do
  use Ecto.Schema
  import Ecto.Changeset

  schema "municipios" do
    field :nome, :string
    field :prefeito, :string
    field :populacao, :integer

    belongs_to(:estado, Municipios.Schema.Estado)

    timestamps()
  end

  @required_params [:nome, :estado_id]
  @optional_params [:prefeito, :populacao]

  def changeset(municipio, attrs) do
    municipio
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
    |> foreign_key_constraint(:estado_id)
  end
end
