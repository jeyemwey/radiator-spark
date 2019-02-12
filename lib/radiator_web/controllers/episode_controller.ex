defmodule RadiatorWeb.EpisodeController do
  use RadiatorWeb, :controller

  alias Radiator.Directory
  alias Radiator.Directory.Episode

  action_fallback RadiatorWeb.FallbackController

  def index(conn, _params) do
    episodes = Directory.list_episodes()
    render(conn, "index.json", episodes: episodes)
  end

  def create(conn, %{"episode" => episode_params}) do
    with {:ok, %Episode{} = episode} <- Directory.create_episode(episode_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.episode_path(conn, :show, episode))
      |> render("show.json", episode: episode)
    end
  end

  def show(conn, %{"id" => id}) do
    episode = Directory.get_episode!(id)
    render(conn, "show.json", episode: episode)
  end

  def update(conn, %{"id" => id, "episode" => episode_params}) do
    episode = Directory.get_episode!(id)

    with {:ok, %Episode{} = episode} <- Directory.update_episode(episode, episode_params) do
      render(conn, "show.json", episode: episode)
    end
  end

  def delete(conn, %{"id" => id}) do
    episode = Directory.get_episode!(id)

    with {:ok, %Episode{}} <- Directory.delete_episode(episode) do
      send_resp(conn, :no_content, "")
    end
  end
end