# test/url_shortener_web/controllers/url_controller_test.exs

defmodule UrlShortenerWeb.UrlControllerTest do
  use UrlShortenerWeb.ConnCase
  import Phoenix.ConnTest


  # Testing the index action
  describe "index/2" do
    test "loads the page correctly", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :index))
      assert html_response(conn, 200)
      assert String.contains?(conn.resp_body, "form") # Ensure form exists on the page
    end
  end

  # Testing the create action
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
    # no worth unit tests, ingerition test should handle this pretty well.
    # test "redirects to the original URL", %{conn: conn} do
    #   # Assuming a URL exists in the database
    #   slug = "existing-slug"
    #   conn = get(conn, Routes.url_path(conn, :show, slug))
    #   assert redirected_to(conn) == "http://original-url-from-db.com"
    # end

    # test "returns 404 for a non-existent slug", %{conn: conn} do
    #   slug = "non-existent-slug"
    #   conn = get(conn, Routes.url_path(conn, :show, slug))
    #   IO.inspect(conn)
    #   assert html_response(conn, 404)
    # end
  end
end
