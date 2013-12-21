---
layout: post
title: " Minimum-Rank Solutions via Nuclear Norm Minimization"
description: "Minimum-Rank Solutions via Nuclear Norm Minimization"
category: "Computer Vision"
tags: [Compressive Sensing, Math, Computer Vision, Nuclear Norm, Optimization, Minimum-Rank]
---
{% include JB/setup %}

## 1. 几种范数
矩阵 $X \in \mathbb{R}^{m \times n}$，$\sigma_i(X)$ 表示 $X$ 的第 $i$ 大奇异值（即 $XX'$ 的第 $i$ 大特征值的均方根）{% cite recht2010guaranteed %}。$r$ 表示矩阵 $X$ 的秩（Rank），也等于 $X$ 非零奇异值的个数。对维度相同的两个矩阵 $X$ 和 $Y$，我们定义在 $\mathbb{R}^{m \times n}$上的内积为

\begin{equation}\label{eq:inner}
\langle X,Y \rangle := Tr(X'Y) = \sum\_{i=1}^m \sum\_{j=1}^n X\_{ij}Y\_{ij}
\end{equation}

### 1. Frobenius范数
矩阵的Frobenius范数又称Hilbert-Schmidt范数，用$$\|  \cdot \|_F$$表示。Frobenius范数也等于奇异值向量的Euclidean范数（或称$$\ell_2$$范数），基于内积\eqref{eq:inner}来计算，即

\begin{equation}\label{eq:Frobenius}
\lVert X \rVert\_F := \sqrt{\langle X,X \rangle} = \sqrt{Tr(X'X)} = \left( \sum\_{i=1}^m \sum\_{j=1}^n X\_{ij}^2 \right)^\frac{1}{2} =  \left( \sum\_{i=1}^r {\sigma\_i}^2 \right)^\frac{1}{2}
\end{equation}

### 2. 算子范数
矩阵的算子范数（operator norm）也称诱导2范数（ induced 2-norm），等于最大奇异值（也就是奇异值向量的 $\ell_{\infty}$ 范数），即
\begin{equation}\label{eq:Operator}
\lVert X \rVert\ := \sigma\_1(X)
\end{equation}

### 3. 核范数
矩阵的核范数（nuclear norm）等于矩阵奇异值的和，即
\begin{equation}\label{eq:Nuclear}
\lVert X \rVert \_* := \sum\_{i=1}^r \sigma\_i(X)
\end{equation}
核范数通常被称为其他一些名字，如Schatten的 1-norm，Ky Fan的 r-norm，或迹范数（trace class norm）。由于奇异值均非负，核范数等于奇异值向量的 $$\ell_1$$ 范数。

对于任意秩不超过 $$r$$ 的矩阵 $$X$$，以上三种范数满足以下不等式条件

\begin{equation}\label{eq:norm-inequ}
\lVert X \rVert  \le \lVert X \rVert \_F \le \lVert X \rVert \_* \le \sqrt{r} \lVert X \rVert\_F \le r\lVert X \rVert
\end{equation}

## 2. 对偶矩阵
对于内积空间上的任意范数$$\lVert  \cdot \rVert$$，存在一个对偶范数（dual norm） $$\lVert  \cdot \rVert _d$$，其定义如下：

\begin{equation}\label{eq:dual-norm}
\lVert X \rVert _d := \max \_{Y} \{ \langle X,Y \rangle : \lVert Y \rVert \le q \}
\end{equation}
特别地，对偶范数的对偶范数为原范数。

对于 $\mathbb{R}^n$ 上的向量，$$\ell_p$$ 范数 $1 < p < \infty$ 的对偶范数为 $$\ell_q$$ 范数，$p,q$ 满足 $$ \frac{1}{p} + \frac{1}{q} = 1$$。类似地，$$\ell_\infty$$ 的对偶范数为 $$\ell_1$$。同样，我们可以推广到我们定义的矩阵范数。例如，Frobenius范数的对偶范数还是Frobenius范数，这可以简单的微积分（或Cauchy-Schwarz）来验证，因为

\begin{equation}\label{eq:Frobenius-verify}
\max \_{Y} \{ Tr(X'Y) : Tr(Y'Y) \le 1\}
\end{equation}
就等于 $$\lVert  X\rVert _F$$，且当 $$Y = X / \lVert X \rVert _F$$时取得最大值。类似地，算子范数的对偶范数是核范数（后面会具体说明）。

## 3. 秩和势函数的凸包络
**凸包络（Convex envelope）**的定义：给定一个凸集 $$\mathcal{C}$$，一个函数（可以为非凸的）$$f : \mathcal{C} \rightarrow \mathbb{R} $$ 的凸包络为使得对所有 $$x \in \mathcal{C}$$ 均有 $$g(x) \le f(x)$$ 的最大凸函数 $$g$$ 。凸包络的定义表明，在所有的凸函数中，$g$ 是对 $f$ 最佳的逐点近似。特别的，如果最优的 $g$ 可以方便的描述出来，函数 $f$ 近似的最小值可以高效地求得。

由链式不等式 \eqref{eq:norm-inequ}可以得到 对所有 $X$ 有 $$rank(X) \ge \lVert X \rVert_* / \lVert X \rVert$$。对所有 $$\lVert X \rVert \le 1$$，均有 $$rank(X) \ge \lVert X \rVert_*$$，因此在算子范数定义的单位球内，核范数是秩函数的较小的凸边界。事实上核范数也是其最紧致的凸边界，即：在集合 $$\{ X \in \mathbb{R}^{m \times n} : \lVert X \rVert \le 1 \}$$ 上，核范数 $$\lVert X \rVert _*$$ 是秩函数 $rank(X)$ 的凸包络。

$$
card(x) \ge \|x\|_1/\|x\|_{\infty}
$$

## 4. 秩的可加性
**次可加性（subadditivity）**：如果从一个线性空间 $\mathcal{S}$ 映射到 $\mathbb{R}$ 的函数 $f$ 满足 $f(x+y) \le f(x) + f(y)$。

**可加性（additivity）**：如果从一个线性空间 $\mathcal{S}$ 映射到 $\mathbb{R}$ 的函数 $f$ 满足 $f(x+y) = f(x) + f(y)$。

对于向量来说，势函数和 $\ell_1$ 范数均满足次可加性。


{% bibliography --file nuclear.bib --cited %}