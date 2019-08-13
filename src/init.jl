__precompile__() # this module is safe to precompile

using Pkg

ENV["PYTHON"]=""
Pkg.build("PyCall")

using PyCall

export f90nml

const f90nml = PyNULL()

function __init__()
    copy!(f90nml, pyimport("f90nml"))
end
