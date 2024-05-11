defmodule UrlShortenerWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use UrlShortenerWeb, :controller
      use UrlShortenerWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def controller do
    quote do
      use Phoenix.Controller, namespace: UrlShortenerWeb

      import Plug.Conn
      import UrlShortenerWeb.Gettext
      alias UrlShortenerWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/url_shortener_web/templates",
        namespace: UrlShortenerWeb

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      use PhoenixHTMLHelpers

      import UrlShortenerWeb.ErrorHelpers
      import UrlShortenerWeb.Gettext
      alias UrlShortenerWeb.Router.Helpers, as: Routes
    end
  end

  def html do
    quote do
      import UrlShortenerWeb.ErrorHelpers
      alias UrlShortenerWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router, helpers: true

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: UrlShortenerWeb.Endpoint,
        router: UrlShortenerWeb.Router,
        statics: UrlShortenerWeb.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/live_view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
