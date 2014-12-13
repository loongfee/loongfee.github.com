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

def findAllFiles(infolder, pat = r'.txt$'):
    fileList = []
    for root, dirs, files in os.walk(infolder):
        for file in files:
            match = re.search(pat, file, re.I)
            if match:
                fileList.append(os.path.join(root, file))
    return fileList

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
    shutil.rmtree(build_path)
os.mkdir(build_path)

# 支持utf-8编码
os.system('chcp 65001')
# 编译网站
os.system('jekyll build -d %s' %build_path)

# 如果编译没有错误就发布网站
print('cd /d %s' %build_path)
os.system('cd /d %s' %build_path)
os.system('C:')
os.system('del /q/a/f/s %s\*.bat'%build_path)
os.system('git init')
os.system('git add .')
os.system('git commit -m "updated site %s"' %date)
os.system(r'git remote add origin git@github.com:%s/%s.github.com.git'%(usr,usr))
os.system(r'git remote set-url origin git@github.com:%s/%s.github.com.git'%(usr,usr))
os.system('git push origin master --force')

os.system('pause')
