"""
Gender (coded 0 = female and
1 = male)

分类变量线性回归
"""


include("../../utils.jl")


desc=Lock5Table(705,"SalaryGender","Gender Discrimination among College Teachers?",["Gender","Salary"])

data=@pipe load_data(desc.name)
gdf=groupby(data,:Gender)
cats=["F","M"]
group_data=[df.Salary for df in gdf]
EqualVarianceTTest(gdf[1].Salary,gdf[2].Salary)
#= 
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0092
=#

"""
    plot_boxplot()
   
"""
function plot_boxplot()
    fig=Figure(resolution=(700,300))
    ax=Axis(fig[1,1],xlabel="gender",ylabel="salary")
    ax.title="gender-salary"
    ax.xticks =(1:2,cats)
    for (idx,df) in enumerate(gdf)
        row=size(df,1)
        boxplot!(ax, fill(idx,row),gdf[idx][:,:Salary]; label = "$(cats[idx])")

    end
    fig
    #save("gender-salary.png",fig)
end

#UnicodePlots.boxplot(cats, group_data, title="gender salary", xlabel="salary", ylabel="gender")

#= 
 gender salary               
            ┌                                        ┐ 
             ╷  ┌──┬────┐          ╷                   
          F  ├──┤  │    ├──────────┤                   
   gender    ╵  └──┴────┘          ╵                   
             ╷  ┌─────┬────────┐                  ╷    
          M  ├──┤     │        ├──────────────────┤    
             ╵  └─────┴────────┘                  ╵    
            └                                        ┘ 
             0                 100                200  
                              salary            
=#


model=lm(@formula(Salary~Gender), data)

#= 
   Salary ~ 1 + Gender

    Coefficients:
    ─────────────────────────────────────────────────────────────────────
                Coef.  Std. Error     t  Pr(>|t|)  Lower 95%  Upper 95%
    ─────────────────────────────────────────────────────────────────────
    (Intercept)  41.631     5.79605  7.18    <1e-09   30.1289     53.1331
    Gender       21.787     8.19685  2.66    0.0092    5.52063    38.0534
    ─────────────────────────────────────────────────────────────────────
=#

#("R²"=>r2(model.model),"Ftest"=>ftest(model.model))
#= 
  ("R²" => 0.0672425268979524, "Ftest" => F-test against the null model:
    F-statistic: 7.06 on 100 observations and 1 degrees of freedom, p-value: 0.0092)
=#


an=anova(model)


