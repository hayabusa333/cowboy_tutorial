exports.config = {

  files: {
    javascripts: {
      joinTo: 'js/app.js'
    },

    stylesheets: {
      joinTo: "css/app.css",
      order: {
        after: ["static/css/app.scss"] // concat app.css last
      }
    }
  },

  conventions: {
    assets: /^(static\/assets)/
  },

  paths: {
    watched: [
      "static",
      "elm/Main.elm"
    ],

    public: "priv/static"
  },

  plugins: {
    elmBrunch: {
      elmFolder: "elm",
      mainModules: ["Main.elm"],
      outputFolder: "../static/vendor"
    },
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/static\/vendor/]
    },
    sass: {
      options: {
        includePaths: ["node_modules/bootstrap-sass/assets/stylesheets"],
        precision: 8
      }
    },
    copycat: {
      "fonts": ["node_modules/bootstrap-sass/assets/fonts/bootstrap"]
    }
  },

  modules: {
    autoRequire: {
      "app.js": ["static/js"]
    }
  },

  npm: {
    enabled: true,
    globals: {
      $: 'jquery',
      jQuery: 'jquery',
      bootstrap: 'bootstrap-sass'
    }
  }
}; 
