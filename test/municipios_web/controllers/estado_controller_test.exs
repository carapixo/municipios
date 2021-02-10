defmodule MunicipiosWeb.EstadoControllerTest do
  use MunicipiosWeb.ConnCase

  alias Municipios.Repo
  alias Municipios.Schema.Estado

  describe "index/2" do
    test "responds with the state catalog", %{conn: conn} do
      insert_estado!()

      response =
        conn
        |> get(Routes.estado_path(conn, :index))

      assert html_response(response, 200) =~ "Listar Estados"
      assert html_response(response, 200) =~ "Cadastrar Estado"
      assert html_response(response, 200) =~ "Paraná"
      assert html_response(response, 200) =~ "Editar"
      assert html_response(response, 200) =~ "Todos os direitos reservados 2021 &copy;"
    end
  end

  describe "new/2" do
    test "responds with the new state form", %{conn: conn} do
      response =
        conn
        |> get(Routes.estado_path(conn, :new))

      assert html_response(response, 200) =~ "Listar Estados"
      assert html_response(response, 200) =~ "Sigla"
      assert html_response(response, 200) =~ "Salvar"
      assert html_response(response, 200) =~ "Todos os direitos reservados 2021 &copy;"
    end
  end

  describe "create/2" do
    test "creates and response with success if attributes are valid", %{conn: conn} do
      response =
        conn
        |> post(Routes.estado_path(conn, :create),
          estado: %{nome: "Santa Catarina", sigla: "SC"}
        )

      assert get_flash(response, :success) == "Estado adicionado com sucesso."
    end

    test "returns an error and does not create if attributes are invalid", %{conn: conn} do
      response =
        conn
        |> post(Routes.estado_path(conn, :create), estado: %{})

      assert get_flash(response, :error) == "Algo deu errado. Verifique."
    end
  end

  describe "edit/2" do
    test "responds with state form", %{conn: conn} do
      estado = insert_estado!()

      response =
        conn
        |> get(Routes.estado_path(conn, :edit, estado.id))

      assert html_response(response, 200) =~ "Listar Estados"
      assert html_response(response, 200) =~ "#{estado.nome}"
      assert html_response(response, 200) =~ "#{estado.sigla}"
      assert html_response(response, 200) =~ "Salvar"
      assert html_response(response, 200) =~ "Todos os direitos reservados 2021 &copy;"
    end
  end

  describe "update/2" do
    test "edits and responds with success if attributes are valid", %{conn: conn} do
      estado = insert_estado!()

      response =
        conn
        |> patch(Routes.estado_path(conn, :update, estado.id),
          estado: %{nome: "Santa Catarina"}
        )

      assert get_flash(response, :success) == "Estado atualizado com sucesso."
      assert redirected_to(response) =~ "/estado"
    end

    test "returns an error and does not edit if attribures are invalid", %{conn: conn} do
      estado = insert_estado!()

      response =
        conn
        |> patch(Routes.estado_path(conn, :update, estado.id),
          estado: %{sigla: ""}
        )

      assert get_flash(response, :error) == "Algo deu errado. Verifique."
      assert html_response(response, 200) =~ "#{estado.nome}"
    end
  end

  describe "delete/2" do
    test "delete the state with valid id", %{conn: conn} do
      estado = insert_estado!()

      response =
        conn
        |> get(Routes.estado_path(conn, :delete, estado.id))

      assert get_flash(response, :success) == "Estado excluído com sucesso."
      assert redirected_to(response) =~ "/estado"
    end
  end

  defp insert_estado! do
    %Estado{nome: "Paraná", sigla: "PR"}
    |> Repo.insert!()
  end
end
