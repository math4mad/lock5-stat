"""
chapter:
page 632  9.32 NBA: Offense or Defense?
data:NBAStandings2019

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(632, "NBAStandings2019", "offensiv-defensiv?", ["Team", "Wins", "Losses", "WinPct", "PtsFor", "PtsAgainst"])

data1 = @pipe load_csv(desc.name, false)|>select(_,[:PtsFor,:WinPct])
data2 = @pipe load_csv(desc.name, false)|>select(_,[:PtsAgainst,:WinPct])
data=[data1,data2]

function plot_scatters()
    fig=Figure(resolution=(800,300))
    
    for idx in 1:2
        labels=names(data[idx])
        ax = Axis(fig[1, idx];xlabel =labels[1], ylabel =labels[2]) 
        Box(fig[1,idx], color=(:orange, 0.1))
        scatter!(ax,eachcol(data[idx])...;markersize=8,color=(:lightgreen,0.3),strokecolor = :black, strokewidth =1)
    end
    fig

end
#fig=plot_scatters();save("UnitD/ch09/imgs/ex-9.32-$(desc.question)-scatterplot.png",fig)

## lin reg 

model1=lm(@formula(WinPct~ PtsFor), data1)
#= 
 WinPct ~ 1 + PtsFor

Coefficients:
────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)   Lower 95%   Upper 95%
────────────────────────────────────────────────────────────────────────────
(Intercept)  -2.13377    0.565723    -3.77    0.0008  -3.2926     -0.974934
PtsFor        0.0236839  0.00508396   4.66    <1e-04   0.0132699   0.0340979
────────────────────────────────────────────────────────────────────────────
=#

model2=lm(@formula(WinPct~ PtsAgainst), data2)
#= 
WinPct ~ 1 + PtsAgainst

Coefficients:
─────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)   Lower 95%    Upper 95%
─────────────────────────────────────────────────────────────────────────────
(Intercept)   2.78965     0.674621    4.14    0.0003   1.40776     4.17155
PtsAgainst   -0.0205882   0.0060625  -3.40    0.0021  -0.0330067  -0.00816978
─────────────────────────────────────────────────────────────────────────────
=#

##  6. r2  compare

("PtFor-r²"=>r2(model1),"PtAgainst-r²"=>r2(model2))
#("PtFor-r²" => 0.43664445291400866, "PtAgainst-r²" => 0.29172775507375337)

## 7 . predict raptor  WinPct with two models
("PtFor-predict²"=>predict(model1,DataFrame(PtsFor=114.4)),"PtAgainst-predict"=>predict(model2,DataFrame(PtsAgainst=108.4)),"Actual"=>0.707)

## 8. results
"""
两个模型似乎都不能很好的预测胜率, 还需要更多的参数参与回归拟合
"""