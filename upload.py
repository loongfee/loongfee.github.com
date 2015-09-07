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
            


# 用户名
usr = 'loongfee'
# 获取日期：
today =datetime.date.today()    #获取今天日期
# 格式化输出
ISOFORMAT='%Y%m%d' #设置输出格式
date = today.strftime(ISOFORMAT)

comment = date
os.system('git init')
os.system('git add .')
os.system('git commit -m "updated site %s"' %comment)
os.system(r'git config remote.origin.url https://%s:a9595965@github.com/%s/%s.github.com.git'%(usr,usr,usr))
os.system(r'git remote add origin https://github.com/%s/%s.github.com.git'%(usr,usr))
os.system(r'git remote set-url origin https://github.com/%s/%s.github.com.git'%(usr,usr))
os.system('git push origin source -f')

os.system('pause')
