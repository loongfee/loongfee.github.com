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
::rd /s /q !build_path!
