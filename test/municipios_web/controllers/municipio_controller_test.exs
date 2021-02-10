defmodule MunicipiosWeb.MunicipioControllerTest do
  use MunicipiosWeb.ConnCase

  alias Municipios.Repo
  alias Municipios.Schema.{Estado, Municipio}

  describe "index/2" do
    test "responds with the city catalog", %{conn: conn} do
      insert_municipio!()

      response =
        conn
        |> get(Routes.municipio_path(conn, :index))

      assert html_response(response, 200) =~ "Listar Municípios"
      assert html_response(response, 200) =~ "Municípios cadastrados: 1"
      assert html_response(response, 200) =~ "Cadastrar Município"
      assert html_response(response, 200) =~ "Toledo"
      assert html_response(response, 200) =~ "Antônio Freitas"
      assert html_response(response, 200) =~ "Editar"
      assert html_response(response, 200) =~ "Todos os direitos reservados 2021 &copy;"
    end
  end

  describe "new/2" do
    test "responds with the new city form", %{conn: conn} do
      response =
        conn
        |> get(Routes.municipio_path(conn, :new))

      assert html_response(response, 200) =~ "Listar Municípios"
      assert html_response(response, 200) =~ "Município"
      assert html_response(response, 200) =~ "Estado"
      assert html_response(response, 200) =~ "Prefeito"
      assert html_response(response, 200) =~ "População"
      assert html_response(response, 200) =~ "Salvar"
      assert html_response(response, 200) =~ "Todos os direitos reservados 2021 &copy;"
    end
  end

  describe "create/2" do
    test "creates and response with success if attributes are valid", %{conn: conn} do
      estado =
        %Estado{nome: "Paraná", sigla: "PR"}
        |> Repo.insert!()

      response =
        conn
        |> post(Routes.municipio_path(conn, :create),
          municipio: %{
            nome: "Toledo",
            prefeito: "Antônio Freitas",
            populacao: 140_580,
            estado_id: estado.id
          }
        )

      assert get_flash(response, :success) == "Município adicionado com sucesso."
    end

    test "returns an error and does not create if attributes are invalid", %{conn: conn} do
      response =
        conn
        |> post(Routes.municipio_path(conn, :create), municipio: %{})

      assert get_flash(response, :error) == "Algo deu errado. Verifique."
    end
  end

  describe "edit/2" do
    test "responds with city form", %{conn: conn} do
      municipio = insert_municipio!()

      response =
        conn
        |> get(Routes.municipio_path(conn, :edit, municipio.id))

      assert html_response(response, 200) =~ "Listar Municípios"
      assert html_response(response, 200) =~ "#{municipio.nome}"
      assert html_response(response, 200) =~ "#{municipio.prefeito}"
      assert html_response(response, 200) =~ "#{municipio.populacao}"
      assert html_response(response, 200) =~ "Salvar"
      assert html_response(response, 200) =~ "Todos os direitos reservados 2021 &copy;"
    end
  end

  describe "update/2" do
    test "edits and responds with success if attributes are valid", %{conn: conn} do
      municipio = insert_municipio!()

      response =
        conn
        |> patch(Routes.municipio_path(conn, :update, municipio.id),
          municipio: %{nome: "Cascavel"}
        )

      assert get_flash(response, :success) == "Município atualizado com sucesso."
      assert redirected_to(response) =~ "/municipio"
    end

    test "returns an error and does not edit if attribures are invalid", %{conn: conn} do
      municipio = insert_municipio!()

      response =
        conn
        |> patch(Routes.municipio_path(conn, :update, municipio.id),
          municipio: %{nome: ""}
        )

      assert get_flash(response, :error) == "Algo deu errado. Verifique."
      assert html_response(response, 200) =~ "#{municipio.prefeito}"
    end
  end

  describe "delete/2" do
    test "delete the city with valid id", %{conn: conn} do
      municipio = insert_municipio!()

      response =
        conn
        |> get(Routes.municipio_path(conn, :delete, municipio.id))

      assert get_flash(response, :success) == "Município excluído com sucesso."
      assert redirected_to(response) =~ "/municipio"
    end
  end

  defp insert_municipio! do
    estado =
      %Estado{nome: "Paraná", sigla: "PR"}
      |> Repo.insert!()

    %Municipio{
      nome: "Toledo",
      prefeito: "Antônio Freitas",
      populacao: 140_580,
      estado_id: estado.id
    }
    |> Repo.insert!()
  end
end
