defmodule MunicipiosWeb.PageController do
  use MunicipiosWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
