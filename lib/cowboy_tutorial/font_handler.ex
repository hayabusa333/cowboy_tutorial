defmodule CowboyTutorial.FontHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:static_font, req)
    {:ok, resp} = css_respons(method, param, req)
    {:ok, resp, opts}
  end

  def css_respons("GET", param, req) do

    headers = String.split(param, ".")
    |> Enum.at(1)
    |> font_header

    {:ok, file} = File.read "priv/static/fonts/#{param}"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def font_header("woff") do %{"content-type" => "application/font-woff"} end

  def font_header("ttf") do %{"content-type" => "application/x-font-ttf"} end

  def font_header("otf") do %{"content-type" => "application/x-font-otf"} end

  def font_header("svgf") do %{"content-type" => "image/svg+xml"} end

  def font_header("eot") do %{"content-tyoe" => "application/vnd.ms-fontobject"} end

end
