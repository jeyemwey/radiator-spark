defmodule RadiatorWeb.EpisodeControllerTest do
  use RadiatorWeb.ConnCase

  alias Radiator.Directory
  alias Radiator.Directory.Episode

  @create_attrs %{
    content: "some content",
    description: "some description",
    duration: "some duration",
    enclosure_length: "some enclosure_length",
    enclosure_type: "some enclosure_type",
    enclosure_url: "some enclosure_url",
    guid: "some guid",
    image: "some image",
    number: 42,
    published_at: "2010-04-17T14:00:00Z",
    subtitle: "some subtitle",
    title: "some title"
  }
  @update_attrs %{
    content: "some updated content",
    description: "some updated description",
    duration: "some updated duration",
    enclosure_length: "some updated enclosure_length",
    enclosure_type: "some updated enclosure_type",
    enclosure_url: "some updated enclosure_url",
    guid: "some updated guid",
    image: "some updated image",
    number: 43,
    published_at: "2011-05-18T15:01:01Z",
    subtitle: "some updated subtitle",
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, description: nil, duration: nil, enclosure_length: nil, enclosure_type: nil, enclosure_url: nil, guid: nil, image: nil, number: nil, published_at: nil, subtitle: nil, title: nil}

  def fixture(:episode) do
    {:ok, episode} = Directory.create_episode(@create_attrs)
    episode
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all episodes", %{conn: conn} do
      conn = get(conn, Routes.episode_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create episode" do
    test "renders episode when data is valid", %{conn: conn} do
      conn = post(conn, Routes.episode_path(conn, :create), episode: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.episode_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some content",
               "description" => "some description",
               "duration" => "some duration",
               "enclosure_length" => "some enclosure_length",
               "enclosure_type" => "some enclosure_type",
               "enclosure_url" => "some enclosure_url",
               "guid" => "some guid",
               "image" => "some image",
               "number" => 42,
               "published_at" => "2010-04-17T14:00:00Z",
               "subtitle" => "some subtitle",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.episode_path(conn, :create), episode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update episode" do
    setup [:create_episode]

    test "renders episode when data is valid", %{conn: conn, episode: %Episode{id: id} = episode} do
      conn = put(conn, Routes.episode_path(conn, :update, episode), episode: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.episode_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some updated content",
               "description" => "some updated description",
               "duration" => "some updated duration",
               "enclosure_length" => "some updated enclosure_length",
               "enclosure_type" => "some updated enclosure_type",
               "enclosure_url" => "some updated enclosure_url",
               "guid" => "some updated guid",
               "image" => "some updated image",
               "number" => 43,
               "published_at" => "2011-05-18T15:01:01Z",
               "subtitle" => "some updated subtitle",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, episode: episode} do
      conn = put(conn, Routes.episode_path(conn, :update, episode), episode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete episode" do
    setup [:create_episode]

    test "deletes chosen episode", %{conn: conn, episode: episode} do
      conn = delete(conn, Routes.episode_path(conn, :delete, episode))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.episode_path(conn, :show, episode))
      end
    end
  end

  defp create_episode(_) do
    episode = fixture(:episode)
    {:ok, episode: episode}
  end
end