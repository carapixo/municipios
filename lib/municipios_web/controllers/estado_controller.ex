defmodule MunicipiosWeb.EstadoController do
  use MunicipiosWeb, :controller

  alias Municipios.Catalog
  alias Municipios.Schema.Estado

  def index(conn, _params) do
    estados = Catalog.list_estados()

    render(conn, "index.html", estados: estados)
  end

  def new(conn, _params) do
    changeset = Catalog.change_estado(%Estado{})

    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    estado = Catalog.get_estado_by_id(id)
    municipios = Catalog.list_municipios_by_uf(id)

    render(conn, "show.html", estado: estado.nome, municipios: municipios)
  end

  def create(conn, %{"estado" => params}) do
    case Catalog.create_estado(params) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Estado adicionado com sucesso.")
        |> redirect(to: "/estado")

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Algo deu errado. Verifique.")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    estado = Catalog.get_estado_by_id(id)
    changeset = Catalog.change_estado(estado)

    render(conn, "edit.html", changeset: changeset, estado: estado)
  end

  def update(conn, %{"id" => id, "estado" => params}) do
    estado = Catalog.get_estado_by_id(id)

    case Catalog.update_estado(estado, params) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Estado atualizado com sucesso.")
        |> redirect(to: "/estado")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Algo deu errado. Verifique.")
        |> render("edit.html", changeset: changeset, estado: estado)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Catalog.delete_estado(id) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Estado excluído com sucesso.")
        |> redirect(to: "/estado")

      {:error, %Ecto.Changeset{} = changeset} ->
        estados = Catalog.list_estados()

        conn
        |> put_flash(:error, "Algo deu errado. Verifique.")
        |> render("index.html", changeset: changeset, estados: estados)
    end
  end
end
