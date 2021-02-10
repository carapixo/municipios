defmodule Municipios.Catalog do
  import Ecto.Query, warn: false

  alias Municipios.Repo
  alias Municipios.Schema.{Estado, Municipio}

  def list_estados do
    Estado
    |> order_by(asc: :nome)
    |> Repo.all()
  end

  def change_estado(%Estado{} = estado, attrs \\ %{}) do
    Estado.changeset(estado, attrs)
  end

  def create_estado(attrs \\ %{}) do
    %Estado{}
    |> Estado.changeset(attrs)
    |> Repo.insert()
  end

  def update_estado(%Estado{} = estado, attrs) do
    estado
    |> Estado.changeset(attrs)
    |> Repo.update()
  end

  def delete_estado(id) do
    get_estado_by_id(id)
    |> Repo.delete()
  end

  def get_estado_by_id(id) do
    Repo.get!(Estado, id)
  end

  def list_municipios do
    Municipio
    |> order_by(asc: :nome)
    |> Repo.all()
    |> Repo.preload(:estado)
  end

  def list_municipios_by_uf(estado_id) do
    Municipio
    |> where(estado_id: ^estado_id)
    |> order_by(asc: :nome)
    |> Repo.all()
  end

  def change_municipio(%Municipio{} = municipio, attrs \\ %{}) do
    Municipio.changeset(municipio, attrs)
  end

  def create_municipio(attrs \\ %{}) do
    %Municipio{}
    |> Municipio.changeset(attrs)
    |> Repo.insert()
  end

  def update_municipio(%Municipio{} = municipio, attrs) do
    municipio
    |> Municipio.changeset(attrs)
    |> Repo.update()
  end

  def delete_municipio(id) do
    get_municipio_by_id(id)
    |> Repo.delete()
  end

  def get_municipio_by_id(id) do
    Repo.get!(Municipio, id)
  end
end
