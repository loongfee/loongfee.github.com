:: ������github

@echo off
SetLocal EnableDelayedExpansion

:: �û���
set usr=loongfee

:: ��ǰ����
set "Ymd=%date:~,4%%date:~5,2%%date:~8,2%"

:: ��ʱ����Ŀ¼
set build_path="%TEMP%Jekyll_build"

:: ������ʱ����Ŀ¼
:: ����Ѿ�������ɾ�������´���

if exist %build_path% (
    ::echo !build_path! exist
    rd /s /q %build_path%
    md %build_path%
    ) else (
    ::echo !build_path! missing
    md %build_path%
)

:: ������վ
chcp 65001
call jekyll build -d %build_path%

:: ������������ֱ������
if   %errorlevel% NEQ 0  exit

:: �������û�д���ͷ�����վ
cd /d %build_path%
C:
del /q/a/f/s %build_path%\*.bat
call git init
call git add .
call git commit -m "updated site %ymd%"
call git remote add origin git@github.com:!usr!/!usr!.github.com.git
call git remote set-url origin git@github.com:!usr!/!usr!.github.com.git
call git push origin master --force

:: ���ص�ǰĿ¼
cd /d %~dp0

:: ɾ����ʱ����Ŀ¼
rd /s /q !build_path!