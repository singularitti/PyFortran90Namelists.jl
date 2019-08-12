using Documenter, PyFortran90Namelists

makedocs(;
    modules=[PyFortran90Namelists],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/singularitti/PyFortran90Namelists.jl/blob/{commit}{path}#L{line}",
    sitename="PyFortran90Namelists.jl",
    authors="Qi Zhang <singularitti@outlook.com>",
    assets=String[],
)

deploydocs(;
    repo="github.com/singularitti/PyFortran90Namelists.jl",
)
