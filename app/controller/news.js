
const Controller = require('egg').Controller;

class NewsController extends Controller {
  async list() {
    const ctx = this.ctx;
    const newsList = await ctx.service.news.get();
    const news = await ctx.service.news.post();

    await ctx.render('news/list.tpl', { list: JSON.parse(newsList) });
  }

  async add(){

      const {ctx,app} = this;

      const row = {
          id:123,
          author:'wrq',
          title:'hello wd',
          content:'wre yuo optp qag dff occ',
          postdate:app.mysql.literals.now
      }


      const addRes = await ctx.service.news.create(row);
      ctx.body = addRes;
  }

  async show(){
      const posts = await this.ctx.service.news.find();
      console.log(posts);
  }
}

module.exports = NewsController;
