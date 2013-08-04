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
虽然[`Github Page`] 服务器不提供插件支持，但是如果需要使用插件可以将 `*.rub` 文件放到网站根目录下的 `_plugins` 文件夹中。遗憾的是这种方式并非万能的，对于一些小巧的、相对独立的插件是可行的，但是对诸如“让Jekyll将Pandoc作为Markdown的渲染器[^loong]”的问题，这种方式就显得力不从心了。

2. [`Github Page`] 服务器上软件的版本偏低  
[`Github Page`] 服务器提供的编译平台是一定的，出于稳定性和大用户群的体验考虑，服务器不可能频繁地更新编译平台，因此其编译平台的版本通常比较滞后。例如写作本文时，[`Github Page`] 服务器提供的 `Jekyll` 及其它依赖库的版本为

{%highlight bash%}
ruby '1.9.3'
gem 'jekyll',     '=1.0.3'
gem 'liquid',     '=2.5.1'
gem 'redcarpet',  '=2.2.2'
gem 'maruku',     '=0.6.1'
gem 'rdiscount',  '=1.6.8'
gem 'RedCloth',   '=4.2.9'
gem 'kramdown',   '=1.0.2'
{%endhighlight%}

而时下的 `ruby` 最新版本为2.0.0p195, `rdiscount` 的最新版本则是2.1.6，有着不小的差距。这样就出现兼容性问题了，本地使用新版本平台能够编译通过的代码提交到 [`Github Page`] 服务器就可能 "`page build failed`" 了。最保险的办法就是将本地的编译平台按照 [`Github Page`] 服务器上地版本来配置，并且不使用插件，这样就能保证本地编译通过的代码提交到 [`Github Page`] 后不出现问题了。但是新版本的新功能和bug的修复无法享用了。

3. 利用 [`Github Page`] 编译并发布网站相对比较耗时   
很显然，既然已经在本地生成好了网站，再将代码上传到服务器重新编译一遍是挺多余的。事实上有时候在晚上上传上去的代码到第二天才会生成好网站。当然，直接将编译好的结果文件 `push` 到 `Github` 也不是立即生效的，但至少不会担心 "`page build failed`" 的错误了。

# 解决方案
[`Github Page`] 官网上提到在网站根目录下创建一个名为 `.nojekyll` 的文件就可以关闭服务器端的 `Jekyll` 编译器，但是即使将 `_site` 文件夹上传到服务器上，网站也不会被发布。笔者找到的解决方案是在 `Github` 该网站的 `Repositor` 中创建一个新的 `branch`，然后用这两个分支分别管理源代码和生成的网站文件。下面介绍具体的实施步骤[^varn]。  
1. 用 `Github` 创建一个 `source` 分支  
打开 `git` 控制台，进入到网站工程目录（以后的操作均在该目录下进行）。用下面的命令将 `master` 分支中的文件移动到一个新的分支中（命名为 `source` ）。

{%highlight bash%}
git checkout -b source master
{%endhighlight%}  
2. 将源代码上传到 `source` 分支  
使用下面的命令将这个新的分支 `push` 到 `Github` 上

{%highlight bash%}
git push -u origin source
{%endhighlight%}    
3. 在 `Github` 上修改 `source` 为默认分支  
登录到 `Github`，在 `repository` 设置中将该工程的默认分支设置为 `source`。这样，当其他人访问你的 `Github` 是默认看到的就是你的源代码而不是生成的网站了。   
4. 编译网站代码并上传到 `master` 分支
这一步的原理是将 `source` 分支中的代码 `build` 到一个临时文件夹中，然后将临时文件夹中的结果文件 `push` 到 `master` 分支中去。步骤稍微有点复杂，如果每次上传网站都要重复操作的话就太麻烦了，好在我们可以将这些机械的操作写到 `batch` 批处理中自动完成。



{%highlight bat%}
:: 发布到github

@echo off

:: 用户名
set usr=anyone

:: 当前日期
set "Ymd=%date:~,4%%date:~5,2%%date:~8,2%"

:: 临时编译目录
set build_path="%TEMP%Jekyll_build"

:: 创建临时编译目录
:: 如果已经存在则删除后重新创建

if exist %build_path% (
    ::echo !build_path! exist
    rd /s /q %build_path%
    md %build_path%
    ) else (
    ::echo !build_path! missing
    md %build_path%
)

:: 支持utf-8编码
chcp 65001
:: 编译网站
call jekyll build -d %build_path%

:: 如果编译出错，直接跳出
if   %errorlevel% NEQ 0  exit

:: 如果编译没有错误就发布网站
cd /d %build_path%
C:
del /q/a/f/s %build_path%\*.bat
call git init
call git add .
call git commit -m "updated site %ymd%"
call git remote add origin git@github.com:!usr!/!usr!.github.com.git
call git remote set-url origin git@github.com:!usr!/!usr!.github.com.git
call git push origin master --force

:: 返回当前目录
cd /d %~dp0

:: 删除临时编译目录
rd /s /q !build_path!
{%endhighlight%}  
创建一个 `windows batch` 文件（扩展名为 `bat`），将以上代码复制粘贴到这个文件中，并把代码 `set usr=anyone` 中的 `anyone` 改成你自己 `Github` 的用户名（也可以直接[下载这个`bat`文件](/assets/share/publish.bat)），然后这个文件存放在网站代码的根目录下，每次需要发布网站的时候直接运行这个`bat`文件即可。  
命令执行过程中可能会出现警告，只要最后能执行通过就没有问题。


[`Github Page`]: http://pages.github.com/ ""
[^varn]: Jekyll : Handling Github page build failure and Jekyll plugins on Github:<http://varunbpatil.github.io/2013/07/06/jekyll-build-fail/#.UfumtI8lzRe>
[^loong]:  让Jekyll将Pandoc作为Markdown的渲染器: <http://loongfee.github.io/blog/2013/08/02/new-post/>