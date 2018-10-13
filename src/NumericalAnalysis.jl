module NumericalAnalysis

#   This file is part of NumericalAnalysis.jl. It is licensed under the MIT license
#   Copyright (C) 2018 Michael Reed

using SyntaxTree, Reduce, NumericalBasis, PyPlot
import Base: print, show
import PyPlot: plot
import Reduce: factor, expand, horner
import NumericalBasis: polyfactors, polyexpand, polyhorner
export PolynomialAnalysis, PolynomialComparison, plot, factor, expand, horner, polyfactors, polyexpand, polyhorner

geonorm(x) = 1/(1-x)

function Ω(p::Array{<:Number,1})
    n = length(p)-1
    for k ∈ 1:length(p)
        p[k] == Inf && (n=k-1; break)
    end
    return n
end

genabs(expr,T::DataType) = SyntaxTree.genfun(SyntaxTree.abs(SyntaxTree.sub(T,expr)),[:x])
genalg(expr,T::DataType) = SyntaxTree.genfun(SyntaxTree.sub(T,expr),[:x])

function stieltjes(set::AbstractRange,expr,T::DataType,T2::DataType=T;logi=log,expi=exp)
    t = genabs(expr,T)
    sc = collect(set)
    esc = expi.(sc)
    #@timed t.([0,1])
    te = (@timed p = t.(esc))[3]
    return Float64.((logi.(abs.(p))-sc).+logi(callcount(expr)*eps(T2))), te
end

function simpson(set::AbstractRange,p::Array{<:Number,1},n::Int=Ω(p))
    s = 4sum(p[1:2:n-1])+2sum(p[2:2:n-1])+sum(p[[1,n]])
    r = -(collect(set)[[n,1]]...)
    #println("Ω = $(collect(set)[n])")
    return s/(3n*r)
end

function exacterr(set::AbstractRange,expr::Array{<:Any,1},T::DataType,rx::Bool,ex::Bool;logi=log,expi=exp)
    funs = genalg.(expr[2:end],T)
    push!(funs,genalg(expr[1],BigFloat))
    esc = collect(set)
    sc = expi.(esc)
    bs = funs[end].(sc)
    bsa = abs.(bs)
    out = Array{Array{Float64,1},1}(undef,length(funs)-1)
    for q ∈ 1:length(funs)-1
        out[q] = Float64.(logi.(abs.(bs-funs[q].(sc)))-esc)
    end
    return out
end

function renormalize!(p)
    n = length(p)-1
    for k ∈ length(p):-1:1
        p[k] == Inf && (p[k]=0; n=k-1)
    end
    return n
end

function errval(expr,T::DataType,N::Int=3000;logi=log,expi=exp)
    set = floatset(T,N;scale=logi)
    points, te = stieltjes(set,expr,T;logi=logi,expi=expi)
    return geonorm(simpson(set,points)), te
    #return simpson(set,points),te
end

#PolynomialComparison(polyfactors(:x,[23029832,2039822,923,1]))

abstract type NumericalData end

include("polynomial.jl")

end # module
