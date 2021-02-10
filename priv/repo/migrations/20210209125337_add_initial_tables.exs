defmodule Municipios.Repo.Migrations.AddInitialTables do
  use Ecto.Migration

  def up do
    create table(:estados, primary_key: false) do
      add :id, :serial, primary_key: true
      add :nome, :string, null: false
      add :sigla, :string, null: false

      timestamps()
    end

    create unique_index(:estados, [:sigla])

    create table(:municipios, primary_key: false) do
      add :id, :serial, primary_key: true
      add :nome, :string, null: false
      add :prefeito, :string
      add :populacao, :integer
      add :estado_id, references(:estados, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:municipios, [:nome])
  end

  def down do
    drop table(:municipios)
    drop table(:estados)
  end
end
