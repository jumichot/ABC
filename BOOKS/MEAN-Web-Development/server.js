var express = require('express');
var app = express();

app.use('/', function(req,res){
  console.log(req.query);
  console.log(req.params);
  res.send('Hello World');
});

app.listen(3000);
console.log('Server running on 3000');

module.exports = app;
