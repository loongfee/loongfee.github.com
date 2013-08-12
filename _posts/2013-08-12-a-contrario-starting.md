---
layout: post
title: " \"a contrario\"：一种基于概率统计的无参数决策模型"
description: ""
category: "Computer Vision"
tags: [Contrario, Math, Helmholtz, Gestalt Theory, Computer Vision]
---
{% include JB/setup %}

## 关于"`a contrario`"模型
虽然这个模型已经提出了十多年，应用也比较广泛了，但是笔者并没查阅到确切的中文翻译，这里姑且将其译为“`悖论模型`”吧。与这个模型密切相关的关键词有：`Gestalt`和`Helmholtz`，它们原本都是属于心理学的范畴，[Agnès Desolneux](http://desolneux.perso.math.cnrs.fr), [Lionel Moisan](http://www.math-info.univ-paris5.fr/~moisan/index.php) and [Jean-Michel Morel](http://scholar.google.com/citations?user=BlEbdeEAAAAJ&hl=en)于1999年将其引入到图像分析领域，提出了一种基于概率统计的无参数决策模型——“`a contrario`”。

## 格式塔（Gestalt）理论
[格式塔（Gestalt）](http://en.wikipedia.org/wiki/Gestalt_psychology)理论最早由德国心理学家Wertheimer于1912年提出。  
“格式塔”（Gestalt）一词具有两种涵义。一种涵义是指形状或形式，亦即物体的性质，例如，用“有角的”或“对称的”这样一些术语来表示物体的一般性质，以示三角形（在几何图形中）或时间序列（在曲调中）的一些特性。在这个意义上说，格式塔意即“形式”。另一种涵义是指一个具体的实体和它具有一种特殊形状或形式的特征，例如，“有角的”或“对称的”是指具体的三角形或曲调，而非第一种涵义那样意指三角形或时间序列的概念，它涉及物体本身，而不是物体的特殊形式，形式只是物体的属性之一。在这个意义上说，格式塔即任何分离的整体[^zhlzw]。  
格式塔理论的基本假设是视觉感知过程中的主动分组原则，简单说来就是在视野范围内，当一些点（或者由点组成的组）具有一种或多种公共的特征时，它们就会被分为一组并形成一个更大的可见目标（也就是一个格式塔）。
根据Gaetano Kanizsa的著作，格式塔理论基本的分组原则包括 vicinity（邻近关系）, similarity（相似性）, continuity of direction（方向的连续性）, amodal completion（补全）, closure（闭合关系）, constant width（一致的宽度）, tendency to convexity（凸包的趋势）, symmetry（对称性）, common motion（公共的运动）, past experience（过去的经验）等 ^[@desolneux2008gestalt]。

## Helmholtz原理


## References

[^zhlzw]: [德]库尔特·考夫卡《 格式塔心理学原理》: <http://www.zhlzw.com/lzsj/mz/tsxl/index.htm>