# lib/url_shortener_web/error_helpers.ex
defmodule UrlShortenerWeb.ErrorHelpers do
    # import Phoenix.HTML
    # import Phoenix.HTML.Form
    use PhoenixHTMLHelpers

  # Translates an error message using gettext
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(UrlShortenerWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(UrlShortenerWeb.Gettext, "errors", msg, opts)
    end
  end

  # Generates error messages for forms
  def error_tag(form, field) do
    if error = Keyword.get(form.errors, field) do
      content_tag(:span, translate_error(error), class: "error")
    end
  end
end
