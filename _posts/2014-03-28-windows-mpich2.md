---
layout: post
title: " 在windows下使用MPICH2进行集群并行计算"
description: "在windows下使用MPICH2进行集群并行计算"
category: "Parallel"
tags: [集群, 并行, MPICH2, MPI, windows]
---
{% include JB/setup %}

## 1. 安装
### (1) MPI版本
MPI（Message Passing Interface）是一种消息传递编程模型，用于实现进程间的通信。MPI从它的诞生开始就有着深深的自然科学家的烙印，MPI标准的制定就是为了自然科学学者实现高速计算。目前MPI以有多种实现，如[MPICH](http://www.mpich.org)、[Open MPI](http://www.open-mpi.org)、[Microsoft MPI](http://msdn.microsoft.com/en-us/library/bb524831(v=vs.85).aspx)、[LAM/MPI](http://www.lam-mpi.org)、[LA-MPI](http://public.lanl.gov/lampi/)等，其中MPICH是windows下比较易用的，本文就是介绍如何在windows下安装和配置[MPICH](http://www.mpich.org)。

MPICH是MPI标准的一种最重要的实现，可以免费从网上下载。MPICH的开发与MPI规范的制订是同步进行的，因此MPICH最能反映MPI的变化和发展。MPICH的开发主要是由Argonne National Laboratory和Mississippi State University共同完成的，在这一过程中IBM也做出了自己的贡献，但是MPI规范的标准化工作是由MPI论坛完成的。MPICH是MPI最流行的非专利实现,由Argonne国家实验室和密西西比州立大学联合开发,具有更好的可移植性。目前（2014年4月）MPICH的最新版本已经更新到mpich-3.1，但是较新的版本并没有提供Windows下二进制安装文件，现阶段多流行的是MPICH2。[这里](http://www.mpich.org/static/downloads/)可以看到MPICH的所有版本，本文使用的是支持提供Windows二进制安装文件的最新版本1.4.1p1，可以选择下载[32位版本](http://www.mpich.org/static/downloads/1.4.1p1/mpich2-1.4.1p1-win-ia32.msi)或者[64位版本](http://www.mpich.org/static/downloads/1.4.1p1/mpich2-1.4.1p1-win-x86-64.msi)，这个可以根据你安装的Windows是32位还是64位来选择。

### (2) 安装MPICH2
Windows版本的安装基本是傻瓜式的，需要注意的是权限问题，尤其是在vista、win7或win8下，必须以管理员身份来运行安装程序（把用户帐户控制UAC也关掉）。也可以直接使用“msiexec /i ***.msi”命令来完成管理员权限下的mpich2安装。安装过程中基本是一路next，就是在选择安装用户的时候需要选择“everyone”，因为后面进行配置的时候可能会用到不同的用户账户。

是的，这样就算安装完了。

## 2. 配置运行环境
### <h3 id='Environment'>(1) 环境变量<h3>
把MPICH2的执行程序目录添加到环境变量PATH中去。路径为“$MPICH2安装路径$\bin”，如：“C:\Program Files\MPICH2\bin”。

### (2) 用户账户设置
要使用MPICH2必须保证当前用户为管理员用户，并且需要设置登录密码。因此，如果你的帐户不满足以上要求就需要进行相应的修改。

### (3) 注册
运行“$MPICH2安装路径$\bin\wmpiregister.exe”，输入用户名和密码进行注册。

### (4) 单机测试
做完以上的配置，应该就能够在单机进行并行计算了，可以用MPICH2自带的工具和计算PI的程序测试一下。
运行“$MPICH2安装路径$\bin\wmpiexec.exe”：

1. 在Application中选择“$MPICH2安装路径$\examples\cpi.exe”

2. 然后调节“Number of processes”以选择使用的进程数

3. 勾选“run in an separate window”

4. 点击“Execute”

接下来会提示输入一个区间，这里输入5000000+回车，然后可以看到计算结果和计算时间。输入0+回车可以退出程序。

可以选择不同的进程数进行测试，看看计算时间有什么变化。通常来说当进程数小于CUP核的个数时，计算时间应该随着进程数线型递减。

### (5) 可能的问题
1. 测试时点击“Execute”，命令行窗口一闪即关

>> 可能是环境变量没有设置好，重新[设置环境变量](#Environment)，必要时需要注销或重启。