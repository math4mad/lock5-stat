## 1 load package
include("../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe,UnicodePlots

## 2. load data

    desc=Lock5Table(391,"ExerciseHours","Exercise Hours diff in boy and girl",["Sex","Exercise"])
    data=@pipe load_data(desc.name)|>select(_,desc.feature)|>groupby(_,desc.feature[1])

## 3. ttest

    data1=sample(data[1].Exercise,2000)
    data2=sample(data[2].Exercise,2000)
    OneSampleTTest(data1,data2)

    ## reject h_0

##
 diff=data1-data2
 histogram(diff)
 
 """
 [-35.0, -30.0) ┤█▌ 18                                     
   [-30.0, -25.0) ┤▎ 3                                       
   [-25.0, -20.0) ┤▉ 12                                      
   [-20.0, -15.0) ┤███▋ 45                                   
   [-15.0, -10.0) ┤███████▎ 89                               
   [-10.0,  -5.0) ┤███████████████████████▉ 300              
   [ -5.0,   0.0) ┤███████████████████▎ 241                  
   [  0.0,   5.0) ┤███████████████████████████████████  439  
   [  5.0,  10.0) ┤███████████████████████▌ 294              
   [ 10.0,  15.0) ┤████████████████████▌ 258                 
   [ 15.0,  20.0) ┤████████████▊ 161                         
   [ 20.0,  25.0) ┤███████▋ 97                               
   [ 25.0,  30.0) ┤███▎ 40                                   
   [ 30.0,  35.0) ┤▎ 3                                       
                  └     
 """

