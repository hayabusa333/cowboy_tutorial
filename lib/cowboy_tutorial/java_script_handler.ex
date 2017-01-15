defmodule CowboyTutorial.JavaScriptHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:static_css, req)
    {:ok, resp} = js_respons(method, param, req)
    {:ok, resp, opts}
  end

  def js_respons("GET", param, req) do
    headers = %{"content-type" => "text/javascript"}
    {:ok, file} = File.read "priv/static/js/#{param}"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

end
