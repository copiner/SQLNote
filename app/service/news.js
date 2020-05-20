// app/service/news.js
const Service = require('egg').Service;

class NewsService extends Service {
  //get
  async get() {
    // read config
    const { serverUrl } = this.config.news;

    const ctx = this.ctx;
    const result = await ctx.curl(`${serverUrl}?foo=bar`);

    return result.data.toString()
  }

  //post
  async post() {
    const ctx = this.ctx;
    const result = await ctx.curl('https://httpbin.org/post', {
      // method is required
      method: 'POST',
      // telling HttpClient to send data as JSON by contentType
      contentType: 'json',
      data: {
        hello: 'world',
        now: Date.now(),
      },
      // telling HttpClient to process the return body as JSON format explicitly
      dataType: 'json',
    });
    return result.data;
  }

  async create(row){
      const { ctx, app } = this;
      const result = await app.mysql.insert('posts',row);
      const insertSuc = result.affectedRows === 1;
  }

  async find(){
      const post = await this.app.mysql.get('posts',{id:123});
      return post;
  }

}

module.exports = NewsService;
