---
layout: post
title: "利用本地编译结果替代Github Page自动生成网站"
description: ""
category: "Jekyll"
tags: [Jekyll, Github, Plugins]
---
{% include JB/setup %}

# 缘起
`Github Page` 提供了自动编译 `Jekyll` 网站的功能，我们只需要将 `Jekyll` 网站代码 `push` 到 `Github` 上，接下来的事情就都可以交给 `Github Page`，一般几分钟后就可以看到由 `Github Page` 重新编译生成的网站了。那末，好好的服务放弃不用，偏偏折腾着直接利用本地编译结果是要闹哪样呢？其实这么捣鼓还真不是因为DT，确实是事发有因。`Github Page` 虽然方便，但是它还是存在几个问题：

1. [`Github Page`] 不支持插件  
虽然[Github Page] 服务器不提供插件支持，但是如果需要使用插件可以将 `*.rub` 文件放到网站根目录下的 `_plugins` 文件夹中。遗憾的是这种方式并非万能的，对于一些小巧的、相对独立的插件是可行的，但是对诸如“让Jekyll将Pandoc作为Markdown的渲染器[^loong]”的问题，这种方式就显得力不从心了。

2. [`Github Page`] 服务器上软件的版本偏低  
[`Github Page`] 服务器提供的编译平台是一定的，出于稳定性和大用户群的体验考虑，服务器不可能频繁地更新编译平台，因此其编译平台的版本通常比较滞后。例如写作本文时，[`Github Page`] 服务器提供的 `Jekyll` 及其它依赖库的版本为
~~~~~~~~~~~~~~~~~~~~~~~~ {bash.}
ruby '1.9.3'
gem 'jekyll',     '=1.0.3'
gem 'liquid',     '=2.5.1'
gem 'redcarpet',  '=2.2.2'
gem 'maruku',     '=0.6.1'
gem 'rdiscount',  '=1.6.8'
gem 'RedCloth',   '=4.2.9'
gem 'kramdown',   '=1.0.2'
~~~~~~~~~~~~~~~~~~~~~~~~
而时下的 `ruby` 最新版本为2.0.0p195, `rdiscount` 的最新版本则是2.1.6，有着不小的差距。这样就出现兼容性问题了，本地使用新版本平台能够编译通过的代码提交到 [`Github Page`] 服务器就可能 "page build failed" 了。最保险的办法就是将本地的编译平台按照 [`Github Page`] 服务器上地版本来配置，并且不使用插件，这样就能保证本地编译通过的代码提交到 [`Github Page`] 后不出现问题了。但是新版本的新功能和bug的修复无法享用了。

3. 利用 [`Github Page`] 编译并发布网站相对比较耗时


[`Github Page`]: http://pages.github.com/ ""
[^varn]: Jekyll : Handling Github page build failure and Jekyll plugins on Github:<http://varunbpatil.github.io/2013/07/06/jekyll-build-fail/#.UfumtI8lzRe>
[^loong]:  让Jekyll将Pandoc作为Markdown的渲染器: <http://loongfee.github.io/blog/2013/08/02/new-post/>