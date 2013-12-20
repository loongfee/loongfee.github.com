---
layout: index
title: 淡朴若水
tagline: [IT, 数学, 遥感]
---

{% for post in site.posts %}
- ### [{{ post.title }}]({{ post.url }}) <time>{{ post.date | date: '%Y-%m-%d'}}</time>

  {{post.summary}}

  [全文阅读 &raquo;]({{ post.url }})
{% endfor %}


