// config/config.default.js
/*
exports.mysql = {
   // database configuration
   client: {
     host: '127.0.0.1',
     port: '3306',
     user: 'root',
     password: '654321',
     database: 'test',
   },
   // load into app, default true
   app: true,
   // load into agent, default false
   agent: false,
 };

*/


exports.keys = "wdaonngg";

exports.view = {
  defaultViewEngine: 'nunjucks',
  mapping: {
    '.tpl': 'nunjucks',
  },
};

exports.cluster = {
    listen:{
        port:7001,
        hostname:'127.0.0.1'
    }
}

exports.sequelize = {
    dialect:'mysql',
    host:'127.0.0.1',
    port:3306,
    database:'doc_default'
}
