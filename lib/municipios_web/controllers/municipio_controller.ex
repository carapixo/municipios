defmodule MunicipiosWeb.MunicipioController do
  use MunicipiosWeb, :controller

  alias Municipios.Catalog
  alias Municipios.Schema.Municipio

  def index(conn, _params) do
    municipios = Catalog.list_municipios()

    render(conn, "index.html", municipios: municipios)
  end

  def new(conn, _params) do
    estados = Catalog.list_estados()
    changeset = Catalog.change_municipio(%Municipio{})

    render(conn, "new.html", estados: estados, changeset: changeset)
  end

  def create(conn, %{"municipio" => params}) do
    case Catalog.create_municipio(params) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Município adicionado com sucesso.")
        |> redirect(to: "/municipio")

      {:error, changeset} ->
        estados = Catalog.list_estados()

        conn
        |> put_flash(:error, "Algo deu errado. Verifique.")
        |> render("new.html", estados: estados, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    estados = Catalog.list_estados()
    municipio = Catalog.get_municipio_by_id(id)
    changeset = Catalog.change_municipio(municipio)

    render(conn, "edit.html", changeset: changeset, municipio: municipio, estados: estados)
  end

  def update(conn, %{"id" => id, "municipio" => params}) do
    municipio = Catalog.get_municipio_by_id(id)

    case Catalog.update_municipio(municipio, params) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Município atualizado com sucesso.")
        |> redirect(to: "/municipio")

      {:error, %Ecto.Changeset{} = changeset} ->
        estados = Catalog.list_estados()

        conn
        |> put_flash(:error, "Algo deu errado. Verifique.")
        |> render("edit.html", changeset: changeset, municipio: municipio, estados: estados)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Catalog.delete_municipio(id) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Município excluído com sucesso.")
        |> redirect(to: "/municipio")

      {:error, %Ecto.Changeset{} = changeset} ->
        municipios = Catalog.list_municipios()

        conn
        |> put_flash(:error, "Algo deu errado. Verifique.")
        |> render("index.html", changeset: changeset, municipios: municipios)
    end
  end
end
