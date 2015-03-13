var express = require('express'),
  morgan = require('morgan'),
  compress = require('compression'),
  bodyParser = require('body-parser'),
  methodOverride = require('method-override');

module.exports = function() {
  var app = express();

  if(process.env.NODE_ENV === 'development'){
    app.use(morgan('dev'));
  } else if (process.env.NODE_ENV === 'production'){
    app.use(compress());
  }

  app.use(bodyParser.urlencoded({extende:true}));
  app.use(bodyParser.json());
  app.use(methodOverride());

  require('../app/routes/index.server.route.js')(app);
  return app;
}
