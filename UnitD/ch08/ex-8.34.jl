#= 
LightatNight
lock5stat page 600
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
或许小鼠增重是因为在不同光照条件下,压力水平不同
通过测量`Corticosterone` 的水平来度量压力程度
通常 Corticosterone 浓度越高, 压力越大
=#

## 1. load package
include("../../utils.jl")

## 2.load  data 

desc=Lock5Table(599,"LightatNight4Weeks","anova",["Light", "Corticosterone"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. anova test
anova_lm(@formula(Corticosterone~Light), df)

#= 
Analysis of Variance

Type 1 test / F test

Corticosterone ~ 1 + Light

Table:
───────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square  F value  Pr(>|F|)
───────────────────────────────────────────────────────────
(Intercept)    1  113644.72    113644.72  35.9910    <1e-05
Light          2    2713.07      1356.54   0.4296    0.6557
(Residuals)   24   75782.07      3157.59             
───────────────────────────────────────────────────────────
=#

## 4. results
"""
p-value=0.6557
因此有充分证据显示在不同光照条件下, 小鼠各组间的压力水平没有差别
""" 


