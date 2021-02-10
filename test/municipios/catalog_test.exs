defmodule Municipios.CatalogTest do
  use MunicipiosWeb.ConnCase

  alias Municipios.Catalog
  alias Municipios.Repo
  alias Municipios.Schema.{Estado, Municipio}

  test "list_estados/0" do
    estado = insert_estado!()

    assert Catalog.list_estados() == [estado]
  end

  test "list_municipios/0" do
    municipio = insert_municipio_with_preload!()

    assert Catalog.list_municipios() == [municipio]
  end

  test "get_estado_by_id/1" do
    estado = insert_estado!()

    assert Catalog.get_estado_by_id(estado.id) == estado
  end

  test "list_municipio_by_uf/1" do
    municipio = insert_municipio!()

    assert Catalog.list_municipios_by_uf(municipio.estado_id) == [municipio]
  end

  test "get_municipio_by_id/1" do
    municipio = insert_municipio!()

    assert Catalog.get_municipio_by_id(municipio.id) == municipio
  end

  defp insert_estado! do
    %Estado{nome: "Paraná", sigla: "PR"}
    |> Repo.insert!()
  end

  defp insert_municipio! do
    estado = insert_estado!()

    %Municipio{
      nome: "Toledo",
      prefeito: "Beto Lunitti",
      populacao: 140_580,
      estado_id: estado.id
    }
    |> Repo.insert!()
  end

  defp insert_municipio_with_preload! do
    estado = insert_estado!()

    %Municipio{
      nome: "Toledo",
      prefeito: "Beto Lunitti",
      populacao: 140_580,
      estado_id: estado.id
    }
    |> Repo.insert!()
    |> Repo.preload(:estado)
  end
end
