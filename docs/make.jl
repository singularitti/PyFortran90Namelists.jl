using PyFortran90Namelists
using Documenter

makedocs(;
    modules = [PyFortran90Namelists],
    authors = "Qi Zhang <singularitti@outlook.com>",
    repo = "https://github.com/singularitti/PyFortran90Namelists.jl/blob/{commit}{path}#L{line}",
    sitename = "PyFortran90Namelists.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://singularitti.github.io/PyFortran90Namelists.jl",
        assets = String[],
    ),
    pages = ["Home" => "index.md"],
)

deploydocs(; repo = "github.com/singularitti/PyFortran90Namelists.jl")
