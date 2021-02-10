defmodule Municipios.Schema.EstadoTest do
  use ExUnit.Case
  doctest Municipios.Schema.Estado
  alias Municipios.Schema.Estado

  describe "changeset/2" do
    test "is not valid with invalid attributes" do
      changeset = Estado.changeset(%Estado{}, %{})

      refute changeset.valid?
    end

    test "is valid with valid attributes" do
      changeset = Estado.changeset(%Estado{}, %{nome: "Parana", sigla: "PR"})

      assert changeset.valid?
    end
  end
end
