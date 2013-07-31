---
layout: post
title: "Hello China"
description: ""
category: 
tags: []
---
{% include JB/setup %}


## 启动本地Jekyll服务（Run Jekyll Locally）[^chengxuyuan]

    $ cd USERNAME.github.com
    $ jekyll serve
其中，`USERNAME`是你的github博客用户名，也就是说需要先定位到本地博客的根目录下。
然后，就可以通过<http://localhost:4000/>来访问你的博客了。

## 停止本地Jekyll服务（Stop Jekyll Locally）
在控制台窗口中使用快捷键来停止服务：

    Ctrl+C
    
## 中文编码问题
修改`convertible.rb`文件中的以下行[^Neptune] <sup>,</sup> [^oschina]：

    self.content = File.read(File.join(base, name))
    
加入utf-8支持，改后为：

    self.content = File.read(File.join(base, name), :encoding => 'utf-8')
    
改后即可正常处理包含中文的post。

[^chengxuyuan]: 利用Jekyll搭建个人博客:<http://www.mceiba.com/develop/jekyll-introduction.html>
[^oschina]: win7使用jekyll的中文编码问题: <http://www.oschina.net/question/195686_72215>
[^Neptune]: Jekyll对中文问题的处理:<http://nepshi.com/2012-10-08/chinese-characters-in-jekyll/>