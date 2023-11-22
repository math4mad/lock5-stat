include("../../utils.jl")

desc=Lock5Table(81,"StudentSurvey","studentsuvey cormartix ",["Exercise","TV","Height", "Weight", "GPA"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

fig=plot_cor_group(data);#save("UnitD/ch09/imgs/ex-9.15.png",fig)


cor_matrix=@pipe Matrix(data)|>cor


cor_n= NamedArray(cor_matrix, (names(data), names(data)))
#= 
   5×5 Named Matrix{Float64}
   A ╲ B │  Exercise         TV     Height     Weight        GPA
─────────┼──────────────────────────────────────────────────────
Exercise │       1.0  0.0322733   0.120141   0.118157  -0.155328
TV       │ 0.0322733        1.0   0.184666   0.176606  -0.132318
Height   │  0.120141   0.184666        1.0   0.629312  -0.127763
Weight   │  0.118157   0.176606   0.629312        1.0  -0.211439
GPA      │ -0.155328  -0.132318  -0.127763  -0.211439        1.0
=#


## heatmap 
fig2=plot_cormatrix(desc,cor_matrix);#save("UnitD/ch09/imgs/ex-9.15-cor-heatmap.png",fig2)



