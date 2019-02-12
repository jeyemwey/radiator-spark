defmodule Radiator.Repo.Migrations.CreateShows do
  use Ecto.Migration

  def change do
    create table(:shows) do
      add :title, :string
      add :subtitle, :string
      add :description, :string
      add :image, :string
      add :author, :string
      add :owner_name, :string
      add :owner_email, :string
      add :language, :string
      add :published_at, :utc_datetime
      add :last_built_at, :utc_datetime

      timestamps()
    end

  end
end
