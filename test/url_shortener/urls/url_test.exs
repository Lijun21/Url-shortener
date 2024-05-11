defmodule UrlShortener.Urls.UrlTest do
  use UrlShortener.DataCase, async: true

  alias UrlShortener.Urls.Url

  describe "changeset/2" do
    @valid_attrs %{
      "original_url" => "https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html",
      "slug" => "i95opj"
    }
    @invalid_url_attrs %{
      "original_url" => "htp://invalid-url",
      "slug" => "i95opj"
    }
    @missing_slug_attrs %{
      "original_url" => "https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html",
      "slug" => ""
    }
    @missing_url_attrs %{
      "original_url" => "",
      "slug" => "i95opj"
    }

    test "valid attributes" do
      changeset = Url.changeset(%Url{}, @valid_attrs)
      assert changeset.valid?
    end

    test "handles missing slug" do
      changeset = Url.changeset(%Url{}, @missing_slug_attrs)
      assert changeset.valid? == false
      assert changeset.errors[:slug] == {"can't be blank", [validation: :required]}
    end

    test "handles missing original_url" do
      changeset = Url.changeset(%Url{}, @missing_url_attrs)
      assert changeset.valid? == false
      assert changeset.errors[:original_url] == {"can't be blank", [validation: :required]}
    end

    test "handles invalid original_url format" do
      changeset = Url.changeset(%Url{}, @invalid_url_attrs)
      assert changeset.valid? == false
      assert Enum.any?(changeset.errors, fn {k, {msg, _}} -> k == :original_url
      and String.contains?(msg, "not a valid URL") end)
    end
  end
end
