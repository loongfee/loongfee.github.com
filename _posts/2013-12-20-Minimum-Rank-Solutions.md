---
layout: post
title: " Minimum-Rank Solutions via Nuclear Norm Minimization"
description: "Minimum-Rank Solutions via Nuclear Norm Minimization"
category: "Computer Vision"
tags: [Compressive Sensing, Math, Computer Vision, Nuclear Norm, Optimization, Minimum-Rank]
---
{% include JB/setup %}

## 几个范数
矩阵 $X \in \mathbb{R}^{m \times n}$，$\sigma_i(X)$ 表示 $X$ 的第 $i$ 大奇异值（即 $XX'$ 的第 $i$ 大特征值的均方根）。$r$ 表示矩阵 $X$ 的秩（Rank），也等于 $X$ 非零奇异值的个数。对维度相同的两个矩阵 $X$ 和 $Y$，我们定义在 $\mathbb{R}^{m \times n}$上的内积为
$$
\langle X,Y \rangle := Tr(X'Y） = \sum_{i=1}^m\sum_{j=1}^nX_{ij}Y_{ij}
$$

{% math %} e^x = \sum\_{n=0}^\infty \frac{x^n}{n!} = \lim\_{n\rightarrow\infty} (1+x/n)^n {% endmath %}
1. Nuclear Norm 
2. 

$$
card(x) \ge \|x\|_1/\|x\|_{\infty}
$$

@article{recht2010guaranteed,
  title={Guaranteed minimum-rank solutions of linear matrix equations via nuclear norm minimization},
  author={Recht, Benjamin and Fazel, Maryam and Parrilo, Pablo A},
  journal={SIAM review},
  volume={52},
  number={3},
  pages={471--501},
  year={2010},
  publisher={SIAM}
}