using PyCall: PyObject

using PyFortran90Namelists: f90nml, @pyinterface

export Parser, reads

mutable struct Parser
    o::PyObject
end
Parser() = Parser(f90nml.Parser())

Base.read(p::Parser, nml_fname::AbstractString, nml_patch_in=nothing, patch_fname=nothing) =
    p.read(nml_fname, nml_patch_in, patch_fname)
reads(p::Parser, nml_string::AbstractString) = p.reads(nml_string)

@pyinterface Parser
