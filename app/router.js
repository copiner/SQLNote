
module.exports = app => {
    const { router, controller } = app;

    router.get('/', controller.home.index);

    router.get('/news', controller.news.list);
    router.get('/news/add', controller.news.add);
    router.get('/news/show', controller.news.show);

    /*
    app.router.resources('routerName', 'pathMatch', controller)
    */
    router.resources('user', '/user', controller.user);
    //app.resources('users', '/users', app.controller.user);
};
