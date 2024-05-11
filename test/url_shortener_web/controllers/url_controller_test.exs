# test/url_shortener_web/controllers/url_controller_test.exs

defmodule UrlShortenerWeb.UrlControllerTest do
  use UrlShortenerWeb.ConnCase, async: true
  import Phoenix.ConnTest
  alias UrlShortener.Repo
  alias UrlShortener.Urls.Url
  alias UrlShortenerWeb.Router.Helpers, as: Routes
  import Ecto.Query


  # Testing the index action
  describe "index/2" do
    test "loads the page correctly", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :index))
      assert html_response(conn, 200)
      assert String.contains?(conn.resp_body, "form") # Ensure form exists on the page
    end
  end

  # # Testing the create action
  describe "create/2" do
    test "creates a new shorten URL successfully", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), %{"original_url" => "http://example.com"})
      assert html_response(conn, 200)
      assert String.contains?(conn.resp_body, "Shortened URL") # Assume the successful page contains this text
    end

    test "handles empty URL input", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), %{"original_url" => ""})
      assert html_response(conn, 200)
      changeset = conn.assigns[:changeset]
      error_message = changeset.errors[:original_url] |> elem(0)
      assert error_message == "can't be blank"
    end

    test "handles invalid URL input", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), %{"original_url" => "hps://www.youtube.com/"})
      # IO.inspect(conn)
      assert html_response(conn, 200)
      changeset = conn.assigns[:changeset]
      error_message = changeset.errors[:original_url] |> elem(0)
      assert error_message == "is not a valid URL"
    end
  end

  # Testing the show action
  describe "show/2" do
    setup do
      test_slug = "test12"
      test_url = "http://example123.com"

      # Ensure no previous test data interferes
      Repo.delete_all(from u in Url, where: u.slug == ^test_slug)

      # Insert a URL record before each test
      url = Repo.insert!(%Url{slug: test_slug, original_url: test_url, click_count: 0})
      {:ok, url: url}
    end

    test "returns 404 when the URL is not found", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :show, "nonexistentslug"))
      assert conn.status == 404
      assert conn.resp_body == "URL not found"
    end

    test "redirects to the original URL when found", %{conn: conn, url: url} do
      conn = get(conn, Routes.url_path(conn, :show, url.slug))
      # IO.inspect(conn, label: "conn")
      location_header = List.keyfind(conn.resp_headers, "location", 0)
      assert location_header != nil
      assert elem(location_header, 1) == "http://example123.com"
    end
  end

end
