#= 
  lock5stat page 562
  true  love revisted
  称为 卡方独立性检验方法
  association between two categorical variables

  以矩阵形式输入数据, total 不需要输入
=#


## 1. load package
include("../../utils.jl")

## data 

data = NamedArray([372 363 735; 807 1005 1812; 34 44 78; 1213 1412 2625], (["Agree", "Disagree", "Don't know", "Total"], ["Male", "Female", "Total"]), ("Attitude", "Sex"))

#= 
  4×3 Named Matrix{Int64}
Attitude ╲ Sex │   Male  Female   Total
───────────────┼───────────────────────
Agree          │    372     363     735
Disagree       │    807    1005    1812
Don't know     │     34      44      78
Total          │   1213    1412    2625
=#
function plot_bar()
    colors = Makie.wong_colors()
    tbl = (x=[1, 1, 1, 2, 2, 2],
        height=[372, 807, 34, 363, 1005, 44],
        grp=[1, 2, 3, 1, 2, 3],)

    fig = Figure()
    ax = Axis(fig[1, 1], xticks=(1:2, ["Male", "Female"]), title="true love  bars")
    GLMakie.barplot!(ax, tbl.x, tbl.height,
        dodge=tbl.grp,
        color=colors[tbl.grp])

    labels = ["Agree", "Disagree", "Don't know"]
    elements = [PolyElement(polycolor=colors[i]) for i in 1:length(labels)]
    title = "Attitude"
    Legend(fig[1, 2], elements, labels, title)
    fig
end
#fig = plot_bar()#;save("UnitD/ch07/imgs/example-7.9-barplot.png",fig)


#res=ChisqTest([372 363; 807 1005; 34 44])
res=ChisqTest(data[1:3,1:2])
"""
H0 ∶ Attitude is not associated with Sex 
Ha ∶ Attitude is associated with Sex
"""
#= 
 Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.129387, 0.318978, 0.0137308, 0.150613, 0.371308, 0.0159835]
    point estimate:          [0.141714, 0.307429, 0.0129524, 0.138286, 0.382857, 0.0167619]
    95% confidence interval: [(0.1215, 0.1624), (0.2872, 0.3281), (0.0, 0.03364), (0.1181, 0.159), (0.3627, 0.4035), (0.0, 0.03745)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           0.0184

Details:
    Sample size:        2625
    statistic:          7.98782843519046
    degrees of freedom: 2
    residuals:          [1.7559, -1.0477, -0.340366, -1.62747, 0.971065, 0.315471]
    std. residuals:     [2.8215, -2.56686, -0.471133, -2.8215, 2.56686, 0.471133]
=#

## 4. results
"""
p-value:           0.0184  <0.05
因此有理由相信对真爱的态度与性别有关
"""