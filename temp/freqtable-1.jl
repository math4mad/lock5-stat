using FreqTables,RCall,PrettyTables


function r_freqtable()
    R"""
        df = data.frame(
        "Agree" = c("Amiya", "Rosy", "Asish"),
        "Gender" = c("Male", "Female", "Male")
        )
        conTable = table(df)
        print(conTable)
    """
end


function freq_table1()
   c1=["Agree","Disagree","Don't know"]
   c2=[372,807,34]
   c3=[363,1005,44]
   df=DataFrame(type=c1,Male=c2,Female=c3)
   transform!(df, [:Male,:Female] => ByRow(+) => :Total)
   #d=[select(df, Symbol(n) => cumsum) for n in names(df[!,2:end]) ]
   d=[sum(x)  for x in eachcol(df[!,2:end])]
   push!(df,["Total",d...])
   @pt df
end
#freq_table()




function freq_table2(df;typename=nothing)
    if typename === nothing
        typename = [["cat$i" for i in 1:size(df,1)]...,"Total"]
    end
   transform!(df, (names(df)) => ByRow(+) => :Total)
   d=sum.(eachcol(df))
   push!(df,d)
   df.Type=typename
   df=select(df,[:Type,Symbol.(names(df[!,1:end-1]))...])
   #@pt df
   return df
end

c2=[372,807,34]
c3=[363,1005,44]
df=DataFrame(Male=c2,Female=c3)
typename=["Agree","Disagree","Don't know","Total"]
df2=freq_table2(df)

