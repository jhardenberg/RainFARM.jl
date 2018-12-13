using Documenter, RainFARM

push!(LOAD_PATH,"../src/")
makedocs(sitename="RainFARM documentation")

deploydocs(
    repo = "github.com/jhardenberg/RainFARM.jl.git",
    devbranch = "master",
    devurl = "dev",
    versions = ["stable" => "v^", "v#.#", devurl => devurl]
)
