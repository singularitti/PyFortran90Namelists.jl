using PyFortran90Namelists
using Documenter

DocMeta.setdocmeta!(PyFortran90Namelists, :DocTestSetup, :(using PyFortran90Namelists); recursive=true)

makedocs(;
    modules=[PyFortran90Namelists],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/MineralsCloud/PyFortran90Namelists.jl/blob/{commit}{path}#{line}",
    sitename="PyFortran90Namelists.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/PyFortran90Namelists.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/PyFortran90Namelists.jl",
    devbranch="main",
)
