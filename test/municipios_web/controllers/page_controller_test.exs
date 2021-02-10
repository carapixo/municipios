defmodule MunicipiosWeb.PageControllerTest do
  use MunicipiosWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Bem vindo. Escolha sua opção no menu acima!"
  end
end
