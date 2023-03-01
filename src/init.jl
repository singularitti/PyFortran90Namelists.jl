using VersionParsing: vparse
using PythonCall: PythonCall, Py, pynew, pyimport, pyhasattr, pyconvert, pycall, pycopy!

export f90nml

const f90nml = pynew()

function __init__()
    pycopy!(f90nml, pyimport("f90nml"))
    # Code from https://github.com/stevengj/PythonPlot.jl/blob/326bbad/src/init.jl#LL149C5-L149C54
    vers = pyconvert(String, f90nml.__version__)
    return global version = try
        vparse(vers)
    catch
        v"0.0.0" # fallback
    end
end
