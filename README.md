# NumericalAnalysis.jl

[![Build Status](https://travis-ci.org/chakravala/NumericalAnalysis.jl.svg?branch=master)](https://travis-ci.org/chakravala/NumericalAnalysis.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/74nv91cgsv9l9uua?svg=true)](https://ci.appveyor.com/project/chakravala/numericalanalysis-jl)
[![Coverage Status](https://coveralls.io/repos/chakravala/NumericalAnalysis.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/chakravala/NumericalAnalysis.jl?branch=master)
[![codecov.io](http://codecov.io/github/chakravala/NumericalAnalysis.jl/coverage.svg?branch=master)](http://codecov.io/github/chakravala/NumericalAnalysis.jl?branch=master)

This package is intended to help provide a complementary detailed analysis of polynomial rounding error estimates using newly defined local and global characteristic methods.
Using automated testing of different polynomial forms, an optimal expression form can be determined.
The methods used include a Simpson-Stieltjes integral method to estimate error bound discrepancy and a computationally efficient characteristic method.
The conclusions of the associated research (to be published by Advances in Engineering Mathematics) indicate the [`SyntaxTree`](https://github.com/chakravala/SyntaxTree.jl)`.exprval` method can be used to select optimal numerical code for polynomial basis functions with the [Reduce.jl](https://github.com/chakravala/Reduce.jl) symbolic rewrite package for the Julia language, which
is based on high-level code generation and macros operating on abstract syntax trees.
Due to the computational simplicity of the expression value method in comparison to the floating point error bound Simpson-Stieltjes integral estimation method, the expression value method is the demonstrably faster, more efficient, and equally reliable method for determining the optimal expression form characterization.

Note that this package is not required to use the characterization method (as it is in the `SyntaxTree` package) and the polynomial forms can be generated by the `Reduce` package.
The purpose of this package is to help with the analysis of the characteristic methods and to explore the local properties of the Wilkinson-type error bounds on the floating point pseudo-algebra for polynomials.

While the package is fully functional, this package continues to be a work in progress and is possibly subject to breaking changes.
In the near future the source code for the research article preprints, documentation, and experimental data will be included in this repository.
