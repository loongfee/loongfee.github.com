#coding=utf-8 
#! python
#-*- coding:utf-8 -*-
import os
import string
import ntpath
import glob
import re
import tempfile
import shutil
import datetime    #调用事件模块
import stat

def findAllFiles(infolder, pat = r'.txt$'):
    fileList = []
    for root, dirs, files in os.walk(infolder):
        for file in files:
            match = re.search(pat, file, re.I)
            if match:
                fileList.append(os.path.join(root, file))
    return fileList

def remove_dir(infolder):
    for root, dirs, files in os.walk(infolder, topdown=False):
        for name in files:
            filename = os.path.join(root, name)
            os.chmod(filename, stat.S_IWUSR)
            os.remove(filename)
        for name in dirs:
            os.rmdir(os.path.join(root, name))
    shutil.rmtree(infolder)
            


# 当前目录
cwd = os.getcwd()
# 用户名
usr = 'loongfee'
# 获取日期：
today =datetime.date.today()    #获取今天日期
# 格式化输出
ISOFORMAT='%Y%m%d' #设置输出格式
date = today.strftime(ISOFORMAT)
# 临时编译目录
build_path = tempfile.gettempdir() + '\\Jekyll_build'
# 创建临时编译目录
# 如果已经存在则删除后重新创建
if os.path.exists(build_path):
    #shutil.rmtree(build_path)
    remove_dir(build_path)
os.mkdir(build_path)

# 支持utf-8编码
os.system('chcp 65001')
# 编译网站
os.system('jekyll build -d %s' %build_path)

# 如果编译没有错误就发布网站
os.chdir(build_path)
os.system('del /q/a/f/s %s\*.bat'%build_path)
os.system('git init')
os.system('git add .')
os.system('git commit -m "updated site %s"' %date)
os.system('git config --global credential.helper wincred')
os.system(r'git remote add origin https://github.com/%s/%s.github.com.git'%(usr,usr))
os.system(r'git remote set-url origin https://github.com/%s/%s.github.com.git'%(usr,usr))
os.system('git push origin master -f')

os.chdir(cwd)
