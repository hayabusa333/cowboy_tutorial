defmodule CowboyTutorial do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
      worker(CowboyTutorial.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: CowboyTutorial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    # ルーティングの設定
    routes = [
      {"/:static_html", CowboyTutorial.HttpHandler, []},
      {"/user/:id", CowboyTutorial.HttpHandler, :user},
      {"/priv/static/fonts/:static_font", CowboyTutorial.FontHandler, []},
      {"/priv/static/css/:static_css", CowboyTutorial.CssHandler, []},
      {"/priv/static/js/:static_js", CowboyTutorial.JavaScriptHandler, []}
    ]

    # http アクセスする箇所の記載
    dispatch = :cowboy_router.compile([{:_, routes}])

    opts = [{:port, 4000}]
    env = %{dispatch: dispatch}

    {:ok, _pid} = :cowboy.start_clear(:http, 100, opts, %{env: env})
  end
end
