defmodule Radiator.Podcast.Episode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "episodes" do
    field :content, :string
    field :description, :string
    field :duration, :string
    field :enclosure_length, :string
    field :enclosure_type, :string
    field :enclosure_url, :string
    field :guid, :string
    field :image, :string
    field :number, :integer
    field :published_at, :utc_datetime
    field :subtitle, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(episode, attrs) do
    episode
    |> cast(attrs, [
      :title,
      :subtitle,
      :description,
      :content,
      :image,
      :enclosure_url,
      :enclosure_length,
      :enclosure_type,
      :duration,
      :guid,
      :number,
      :published_at
    ])
    |> validate_required([])
  end
end
