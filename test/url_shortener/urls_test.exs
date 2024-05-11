defmodule UrlShortener.UrlsTest do
  use UrlShortener.DataCase, async: false

  alias UrlShortener.Urls
  alias UrlShortener.Urls.Url

  setup do
    # Checkout the sandbox connection
    case Ecto.Adapters.SQL.Sandbox.checkout(UrlShortener.Repo) do
      :ok -> :ok
      {:already, :owner} -> IO.puts("Already checked out")
      other -> IO.puts("Unexpected checkout result: #{inspect(other)}")
    end

    # Check-in the sandbox connection after the test
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.checkin(UrlShortener.Repo) end)
  end


  describe "increment_click_count/1" do
    test "increments the click count of a URL" do
      # Initially insert a URL with a click_count of 0
      url = %Url{original_url: "https://example.com", slug: "inc123", click_count: 0}
      {:ok, url} = Repo.insert(url)

      # Increment the click count
      {:ok, updated_url} = Urls.increment_click_count(url)

      # Assert that the click count has been incremented
      assert updated_url.click_count == 1
    end
  end

  describe "create_url/1" do
    test "creates a new URL with generated slug" do
      attrs = %{"original_url" => "https://newsite.com"}
      {:ok, url} = Urls.create_url(attrs)

      # Check the slug is not nil and exactly 6 characters long
      assert url.slug != nil
      assert String.length(url.slug) == 6
      # Check the slug only contains valid Base36 characters
      assert Regex.match?(~r/^[0-9a-z]{6}$/, url.slug)
      # Verify the original URL is correctly set
      assert url.original_url == "https://newsite.com"
    end

    test "handles invalid URLs" do
      attrs = %{"original_url" => "invalidurl"}
      {:error, changeset} = Urls.create_url(attrs)

      errors = errors_on(changeset) |> Map.fetch!(:original_url)
      assert "is not a valid URL" in errors
    end
  end


end
