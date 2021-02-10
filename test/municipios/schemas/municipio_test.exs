defmodule Municipios.Schema.MunicipioTest do
  use ExUnit.Case
  doctest Municipios.Schema.Municipio
  alias Municipios.Schema.Municipio

  describe "changeset/2" do
    test "is not valid with invalid attributes" do
      changeset = Municipio.changeset(%Municipio{}, %{})

      refute changeset.valid?
    end

    test "is valid with valid attributes" do
      changeset = Municipio.changeset(%Municipio{}, %{nome: "Toledo", estado_id: 1})

      assert changeset.valid?
    end
  end
end
