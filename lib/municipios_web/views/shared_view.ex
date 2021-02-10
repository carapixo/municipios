defmodule MunicipiosWeb.SharedView do
  use MunicipiosWeb, :view

  def render_alerts(alerts) do
    alerts
    |> Enum.map(fn {key, message} ->
      render("_#{key}.html", message: message)
    end)
  end
end
