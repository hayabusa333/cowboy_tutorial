defmodule CowboyTutorial.HttpHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:static_html, req)
    {:ok, resp} = html_respons(method, param, req)
    {:ok, resp, opts}
  end

  def html_respons("GET", param, req) when (param == "home" or param == "help") do
    headers = %{"content-type" => "text/html"}
    {:ok, file} = File.read "priv/static/html/#{param}.html"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def html_respons("GET", param, req) do
    headers = %{"content-type" => "text/html"}
    body = ""
    {:ok, resp} = :cowboy_req.reply(404, headers, body, req)
  end

end
