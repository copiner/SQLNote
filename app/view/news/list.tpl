<html>
  <head>
    <title>Egg Clone</title>
    <link rel="stylesheet" href="/public/css/news.css" />
  </head>
  <body>
    <dl>
    {% for key, value in list %}
        <dt>{{ key|e }}</dt>
        <dd>{{ value|e }}</dd>
    {% endfor %}
    </dl>
    {{ helper.relativeTime(item.time) }}
  </body>
</html>
