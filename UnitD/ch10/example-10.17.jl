"""

分类变量线性回归
"""


## 1. load package
include("../../utils.jl")


## 2. load data
desc=Lock5Table(684,"SalaryGender","Gender Discrimination among College Teachers?",["PhD","Salary"])
data=@pipe load_csv(desc.name)|>select(_,desc.feature)
gdf=groupby(data,:PhD)
cats=["0","1"]  # 0 =no phd, 1 =with phd
group_data=[df.Salary for df in gdf]

## 3. boxplot 

UnicodePlots.boxplot(cats, group_data, title="degree salary", xlabel="salary", ylabel="phd")
#= 
 degree salary               
         ┌                                        ┐ 
          ╷ ┌─┬───┐                ╷                
       0  ├─┤ │   ├────────────────┤                
   phd    ╵ └─┴───┘                ╵                
            ╷      ┌─────┬───┐                 ╷    
       1    ├──────┤     │   ├─────────────────┤    
            ╵      └─────┴───┘                 ╵    
         └                                        ┘ 
          0                 100                200  
                           salary                
=#


## 4.  lr

model=lm(@formula(Salary~PhD), data)
#= 
Salary ~ 1 + PhD

Coefficients:
──────────────────────────────────────────────────────────────────────
               Coef.  Std. Error     t  Pr(>|t|)  Lower 95%  Upper 95%
──────────────────────────────────────────────────────────────────────
(Intercept)  33.8631     4.5177   7.50    <1e-10    24.8979    42.8283
PhD          47.8497     7.23411  6.61    <1e-08    33.4939    62.2056
──────────────────────────────────────────────────────────────────────
=#

## 5. ftest
ftest(model.model)
#= 
F-test against the null model:
F-statistic: 43.75 on 100 observations and 1 degrees of freedom, p-value: <1e-08
=#


