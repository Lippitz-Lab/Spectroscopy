### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ da692610-277d-49ac-b829-522054a9d43e
using Unitful

# ╔═╡ 14e2d50e-0951-4365-ab57-15645b5aa1c8
module MyUnits
	using Unitful
	@unit D "D" Debye 3.33e-30u"C*m" true;
end

# ╔═╡ de86a366-e2b1-11ee-3fd3-2de17537a1fb
md"""
# 2 Fluorescence Check units
"""

# ╔═╡ 901873ec-7068-4686-b3be-d2acfad7d38d
md"""
This script only checks for units, so the values of the variables have no meaning. I just want to make sure that the equations match in terms of their units, and to have an easy reference for the units of the variables.
"""

# ╔═╡ 1f116a57-7a70-4f1c-b685-bcdcc0bf0e3a
import PhysicalConstants.CODATA2018: N_A	, m_e, e, ε_0, c_0, ħ

# ╔═╡ 14a7feb7-1eed-400e-952f-990ab6d17b66
Unitful.register(MyUnits);

# ╔═╡ a683cb31-b820-4c48-88ec-06184b2ac27f
md"""
## Wavelength to frequency
"""

# ╔═╡ 13df8f0f-92ea-4534-a863-e3092d11fd9b
λ = 500u"nm";

# ╔═╡ 01fb702c-7555-45ad-958e-130704d1e937
Δλ = 10u"nm";

# ╔═╡ baf003c1-a8c0-405f-a102-0139e7f45776
Δν = c_0 / λ^2 * Δλ |> u"Hz"

# ╔═╡ 13783039-af4e-4a4d-b127-d0c32cdff098
md"""
## Einstein coeffs
"""

# ╔═╡ 0855abcd-a611-4a55-902a-0f2426184512
ω = 2π * c_0 / λ |> u"Hz"

# ╔═╡ dd8044f0-2399-4032-ae6c-2506442b5ba4
u = ω^2 / (π^2 * c_0^3) * ħ * ω |> u"J*m^-3*Hz^-1" 

# ╔═╡ b7b6c2ad-3afa-4282-9c6a-de44916c1ed9
A_21 = 1u"Hz"

# ╔═╡ 9f96bc15-e048-49cf-be7c-01a7a56521c9
B_12 = 1u"Hz" / u |> u"m^3*J^-1*Hz^2" 

# ╔═╡ 71e1ca24-01e9-4319-8917-4ec773bc20e8
B_12 * ħ * ω^3 / (π^2 * c_0^3) |> u"Hz"

# ╔═╡ 93e21148-ad26-4a1f-85c8-4444fd2f1254
σ = 1u"nm^2";

# ╔═╡ c40856cf-25a3-479e-b07b-f861f7248f52
dω = 1u"Hz";

# ╔═╡ 9c70f808-68c8-4937-ad03-6db35b33f77b
eq11_LHS = σ * dω

# ╔═╡ 4e7a0358-5b88-401e-8796-abda24d6f2c9
eq11_RHS = ħ * ω * B_12 * u /(c_0 * u) |> u"Hz*nm^2"

# ╔═╡ 0208781f-7330-4d22-b150-1d9802da11bf
μ = 1u"D";

# ╔═╡ a3f85988-4f06-472d-a0a8-16a6e71a3856
B12_eq12 = π / ( 3* ħ^2 * ε_0) * abs(μ)^2 |> u"m^3*J^-1*Hz^2" 

# ╔═╡ 9d73980e-976f-40a2-9ed8-26795c7fffa2
md"""
## Absorption to emission
"""

# ╔═╡ b9e6f448-c6c2-4896-b284-abd7a0f5212e
ϵ = 1.5u"1/(M*cm)";

# ╔═╡ 4ff5f093-7a39-4e86-a8e6-6771186742d8
C = 1u"M";

# ╔═╡ a47b233d-b73e-4ad6-b81b-9a198792db58
d = 1u"cm";

# ╔═╡ 4ed44a99-7678-429c-97e3-0510062160a8
A = ϵ * C * d

# ╔═╡ c230984a-2ac6-47cd-9d9e-01c6d6f76d21
T = 10^(-A)

# ╔═╡ 403ad416-84ed-49af-8a42-fb6817d62396
σ_abs = log(10)./ N_A * ϵ |> upreferred

# ╔═╡ 3184347a-7c01-47a9-a2d1-23036daefc5b
eq13_1 = N_A * C * d / log(10) * σ_abs |> upreferred

# ╔═╡ a9040765-f53f-428b-b9d2-65c7582cf47f
L = 1 / dω

# ╔═╡ adcf1835-a575-4bbc-ad9f-d0089cd12eb1
eq13_2 = N_A * C * d * π * ω /( log(10) * ħ * c_0 * ε_0) * L * abs(μ)^2 |> upreferred

# ╔═╡ 60631746-a33b-4e98-ac0c-29165a88bb31
ω^3 / ( 3 * π * ħ * ε_0 * c_0^3) * abs(μ)^2 |> upreferred

# ╔═╡ 18b2b9dd-2283-4d2e-8fc1-7d8bd280822a
md"""
## Strickler-Berg
"""

# ╔═╡ 10443605-93bb-41fd-9ce8-b1eebb301aa4
eq26 = log(10) / (π^2 * c_0^2 * N_A) * 1 / (ω^-3) * ϵ / ω * dω |> upreferred

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PhysicalConstants = "5ad8b20f-a522-5ce9-bfc9-ddf1d5bda6ab"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
PhysicalConstants = "~0.2.3"
Unitful = "~1.19.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "bd1fe6de7f03bd2d0dad6d1281c5730f984a1323"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "LinearAlgebra", "MacroTools", "Markdown", "Test"]
git-tree-sha1 = "c0d491ef0b135fd7d63cbc6404286bc633329425"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.36"

    [deps.Accessors.extensions]
    AccessorsAxisKeysExt = "AxisKeys"
    AccessorsIntervalSetsExt = "IntervalSets"
    AccessorsStaticArraysExt = "StaticArrays"
    AccessorsStructArraysExt = "StructArrays"
    AccessorsUnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    Requires = "ae029012-a4dd-5104-9daa-d747884805df"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "575cd02e080939a33b6df6c5853d14924c08e35b"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.23.0"

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

    [deps.ChainRulesCore.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "c955881e3c981181362ae4088b35995446298b80"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.14.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c53fc348ca4d40d7b371e71fd52251839080cbc9"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.4"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "68772f49f54b479fa88ace904f6127f0a3bb2e46"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.12"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Measurements]]
deps = ["Calculus", "LinearAlgebra", "Printf", "Requires"]
git-tree-sha1 = "bdcde8ec04ca84aef5b124a17684bf3b302de00e"
uuid = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
version = "2.11.0"

    [deps.Measurements.extensions]
    MeasurementsBaseTypeExt = "BaseType"
    MeasurementsJunoExt = "Juno"
    MeasurementsRecipesBaseExt = "RecipesBase"
    MeasurementsSpecialFunctionsExt = "SpecialFunctions"
    MeasurementsUnitfulExt = "Unitful"

    [deps.Measurements.weakdeps]
    BaseType = "7fbed51b-1ef5-4d67-9085-a4a9b26f478c"
    Juno = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.PhysicalConstants]]
deps = ["Measurements", "Roots", "Unitful"]
git-tree-sha1 = "cd4da9d1890bc2204b08fe95ebafa55e9366ae4e"
uuid = "5ad8b20f-a522-5ce9-bfc9-ddf1d5bda6ab"
version = "0.2.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Roots]]
deps = ["Accessors", "ChainRulesCore", "CommonSolve", "Printf"]
git-tree-sha1 = "1ab580704784260ee5f45bffac810b152922747b"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "2.1.5"

    [deps.Roots.extensions]
    RootsForwardDiffExt = "ForwardDiff"
    RootsIntervalRootFindingExt = "IntervalRootFinding"
    RootsSymPyExt = "SymPy"
    RootsSymPyPythonCallExt = "SymPyPythonCall"

    [deps.Roots.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalRootFinding = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"
weakdeps = ["ConstructionBase", "InverseFunctions"]

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╟─de86a366-e2b1-11ee-3fd3-2de17537a1fb
# ╟─901873ec-7068-4686-b3be-d2acfad7d38d
# ╠═da692610-277d-49ac-b829-522054a9d43e
# ╠═1f116a57-7a70-4f1c-b685-bcdcc0bf0e3a
# ╠═14e2d50e-0951-4365-ab57-15645b5aa1c8
# ╠═14a7feb7-1eed-400e-952f-990ab6d17b66
# ╟─a683cb31-b820-4c48-88ec-06184b2ac27f
# ╠═13df8f0f-92ea-4534-a863-e3092d11fd9b
# ╠═01fb702c-7555-45ad-958e-130704d1e937
# ╠═baf003c1-a8c0-405f-a102-0139e7f45776
# ╟─13783039-af4e-4a4d-b127-d0c32cdff098
# ╠═0855abcd-a611-4a55-902a-0f2426184512
# ╠═dd8044f0-2399-4032-ae6c-2506442b5ba4
# ╠═b7b6c2ad-3afa-4282-9c6a-de44916c1ed9
# ╠═9f96bc15-e048-49cf-be7c-01a7a56521c9
# ╠═71e1ca24-01e9-4319-8917-4ec773bc20e8
# ╠═93e21148-ad26-4a1f-85c8-4444fd2f1254
# ╠═c40856cf-25a3-479e-b07b-f861f7248f52
# ╠═9c70f808-68c8-4937-ad03-6db35b33f77b
# ╠═4e7a0358-5b88-401e-8796-abda24d6f2c9
# ╠═0208781f-7330-4d22-b150-1d9802da11bf
# ╠═a3f85988-4f06-472d-a0a8-16a6e71a3856
# ╟─9d73980e-976f-40a2-9ed8-26795c7fffa2
# ╠═b9e6f448-c6c2-4896-b284-abd7a0f5212e
# ╠═4ff5f093-7a39-4e86-a8e6-6771186742d8
# ╠═a47b233d-b73e-4ad6-b81b-9a198792db58
# ╠═4ed44a99-7678-429c-97e3-0510062160a8
# ╠═c230984a-2ac6-47cd-9d9e-01c6d6f76d21
# ╠═403ad416-84ed-49af-8a42-fb6817d62396
# ╠═3184347a-7c01-47a9-a2d1-23036daefc5b
# ╠═a9040765-f53f-428b-b9d2-65c7582cf47f
# ╠═adcf1835-a575-4bbc-ad9f-d0089cd12eb1
# ╠═60631746-a33b-4e98-ac0c-29165a88bb31
# ╟─18b2b9dd-2283-4d2e-8fc1-7d8bd280822a
# ╠═10443605-93bb-41fd-9ce8-b1eebb301aa4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
