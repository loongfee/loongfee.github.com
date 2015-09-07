---
layout: post
title: "用Notepad++替换系统记事本"
description: "主要是借助AutoHotkey和映像劫持结束来实现用Notepad++替换系统记事本的功能，方法具有普适性，理论上说可以支持用任意软件替换系统相应的默认程序。"
category: "软件"
tags: [Notepad++, 记事本, AutoHotkey, 映像劫持]
keywords: [Notepad++, notepad, 记事本, AutoHotkey, 映像劫持, Image File Execution Options, vim, notepad2]
---

本文主要介绍如何借助AutoHotkey和映像劫持结束来实现用Notepad++替换系统记事本的功能，方法具有普适性，理论上说可以支持用任意软件替换系统相应的默认程序。

## 1. 什么映像劫持技术
简单说来，[映像劫持技术(Image File Execution Options)](http://baike.baidu.com/view/1296399.htm)就是将某个`程序A`直接映射到另一个`程序B`上去，然后在试图执行`程序A`时自动执行了`程序B`。而这一切只需要在注册表中添加一条语句即可实现，不需要修改系统中的文件和其他配置。想要恢复原有程序时，只需从注册表中删除这条语句就行了。整个过程非常绿色环保，不会对系统造成其他影响。  
以使用Notepad2替换记事本[^portablesoft]为例，具体过程主要包括：
  
+ 创建如下注册表项：`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe`，如果无法修改，需要先右键取得权限  
+ 在`notepad.exe`注册表项中，创建名为`Debugger`的字符串值(`REG_SZ`)  
+ 修改字符串值`Debugger`的数据为`Notepad2.exe`的完整路径，最后以 `/z` 参数结尾。
通过镜像劫持技术将记事本替换为Notepad2的方案十分非常完美了，`Notepad2`官方文档[^notepad2]中就给出了实现方法，其中的参数 `/z` 应该就是特地为替换记事本而设计的。  

平心而论，`Notepad2`已经是一款非常优秀的记事本替代品了，启动速度快，支持自定制，功能也非常丰富，尤其是[精品绿色便携软件](http://www.portablesoft.org)提供的修改版[Notepad2-mod](http://www.portablesoft.org/notepad2-replacement/)，功能更强大了，一般使用已经完全足够了。但是与同样开源免费的[`Notepad++`](http://notepad-plus-plus.org)相比，在对文本文件(*.txt)编码字符集的自动识别能力上差了不少，有的不能自动识别，显示乱字符。另外一个硬伤就是不支持多标签，在打开多个文件时窗口是很凌乱的。

## 2. 尝试用`Notepad++`替换系统记事本
首先，笔者尝试了将在`Notepad2`中得到完美应用的`映像劫持技术`直接搬到`Notepad++`中来，结果是失败的：  

> 直接使用`镜像劫持`方案修改后，运行记事本时会自动打开`notepad.exe`文件。原因是`notepad++.exe`不支持用参数 `/z` 跳过后续第一个参数。

## 3. 万能工具 `AutoHotkey` 出马
虽然`Notepad++`本身没有提供`跳过后续第一个参数`的功能，但是并不是没有办法实现的。因为 `AutoHotkey` 的存在，几乎一切都是可以自己定制的，更何况是这么一个小小的参数。下面一段代码就是通过 `AutoHotkey`来跳过 `notepad.exe` 参数，解决自动打开`notepad.exe`的问题。

~~~~ahk
; cnpp.ahk
cpath =
Loop, %0%
{
    param := %A_Index%
    If param not contains notepad.exe
    cpath = %cpath% %param%
}
Run notepad++.exe "%cpath%"
~~~~

编译这段 `AHK` 代码，生成一个名为`cnpp`的可执行程序。 然后通过下面的 `Batch` 命令直接添加注册表语句，实现系统记事本的映像劫持。

~~~~bat
:: 替换记事本.bat
@echo off
cd /d "%~dp0"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /d "%~dp0cnpp.exe"
cls
echo cnpp已设为默认编辑器。
pause
~~~~

需要回复系统记事本时，直接运行下面的 `Batch` 代码就行了。

~~~~bat
:: 还原记事本.bat
@echo off
cd /d "%~dp0"
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /f
cls
echo Notepad已还原为默认编辑器
pause
~~~~

## 4. 纯 `AutoHotkey` 实现
其实到上一节为止，设置`Notepad++`替换系统记事本的功能已经实现了，这一节只是将这个过程做的更方便更友好。

~~~~ahk
; cnpp安装.卸载.ahk
RegRead, Hijack, HKLM, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe,debugger
;MsgBox %hijack%
If(Hijack!=""){
	RegDelete HKLM, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe,debugger
	TrayTip,,Notepad为默认编辑器,2000
	Sleep ,1500
	}
Else{
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe , debugger, ccaiai
	RegRead, Hijack, HKLM, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe,debugger
	If(Hijack!="ccaiai"){
	MsgBox, 16, 请先关闭杀毒软件后再重试
	ExitApp
	}
	HijackPath=%A_WorkingDir%\cnpp.exe
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe , debugger, %HijackPath%
	TrayTip,,cnpp为默认编辑器,2000
	Sleep ,1500
}
~~~~

编译完 `AutoHotkey` 代码得到的 `exe` 程序放到 `notepad++.exe` 同目录下，执行  `cnpp安装.卸载.exe` 程序即可替换或还原系统记事本。  
*`AutoHotkey` 代码参考了 `ccaiai` 设置VIM为默认编辑器的代码。*  
*P.S. 再次体会到 `AutoHotkey` 的强大。*

[^portablesoft]: 通过映像劫持实现Notepad2替换记事本: <http://www.portablesoft.org/notepad2-replacement/>
[^notepad2]: Notepad2 ― Replacing Windows Notepad: <http://www.flos-freeware.ch/doc/notepad2-Replacement.html>