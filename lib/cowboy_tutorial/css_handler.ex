defmodule CowboyTutorial.CssHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:static_css, req)
    {:ok, resp} = css_respons(method, param, req)
    {:ok, resp, opts}
  end

  def css_respons("GET", param, req) do
    headers = %{"content-type" => "text/css"}
    {:ok, file} = File.read "priv/static/css/#{param}"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

end
