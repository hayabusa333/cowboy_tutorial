var App = {
  run: function run() {
    var elmDiv = document.getElementById('elm-main')
    var elmApp = Elm.Main.embed(elmDiv)
  }
};

module.exports = {
  App: App
};
