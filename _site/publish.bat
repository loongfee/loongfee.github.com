:: 发布到github

@echo off
SetLocal EnableDelayedExpansion

:: 用户名
set usr=loongfee

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

:: 编译网站
chcp 65001
jekyll build  %build_path%

echo %errorlevel%

del /q/a/f/s %build_path%\publish.bat
exit
rd /s /q !build_path!

:: 如果编译没有错误就发布网站
::if   %errorlevel% (
    cd /d d:sdk %build_path%
    git init
    git add .
    git commit -m "updated site %ymd%"
    git remote add origin git@github.com:!usr!/!usr!.github.com.git
    git push origin master --force
::)

cd /d %~dp0

rd /s /q !build_path!
