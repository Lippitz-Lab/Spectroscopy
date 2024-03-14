### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 989a385c-20a8-492e-9183-c0aa2a9e08b0
using Unitful

# ╔═╡ c91c4202-e11d-11ee-388f-e7bb53c78523
md"""
# 1 Absorption: Check units
"""

# ╔═╡ 1d5ec330-cc57-4c11-9821-05e16a94bd82
md"""
This script only checks for units, so the values of the variables have no meaning. I just want to make sure that the eaqutions fit in terms of their units, and to have an easy reference for the units of the variables.
"""

# ╔═╡ 6753972d-e492-43da-967d-708b7cafba2d
import PhysicalConstants.CODATA2018: N_A	, m_e, e, ε_0, c_0, ħ

# ╔═╡ 08a6da7b-3dd6-4492-8660-a40b1854a9e9
md"""
## Absorption cross section
"""

# ╔═╡ cb97a656-0952-465a-abad-da0812f4da5e
P0 = 1u"mW";

# ╔═╡ 9b63cd47-142d-47c3-9806-1a3a57502984
L = 1.0u"cm";

# ╔═╡ 76f3bf56-ab32-490c-a49f-4ad72b1ade0a
C = 1u"M";

# ╔═╡ eec0651f-24fe-4fe5-aba2-679539cf9a3a
ϵ = 2u"1/(M*cm)";

# ╔═╡ 33e6fc57-e102-4829-ab0f-9787c37666a2
A = ϵ * C * L |> upreferred

# ╔═╡ 425d73f4-e30c-4f02-8b5e-3d9903a3be71
T = 10^(-A )

# ╔═╡ 63e83264-60d2-4825-a8ef-2b7a19b2093f
σ_abs = log(10)./ N_A * ϵ |> upreferred

# ╔═╡ 53d3a3c1-420d-4b00-b580-40f29f4fcd35
md"""
## Lorentz oscillator
"""

# ╔═╡ 8ac5281a-5970-45ce-bea8-9409e6ff30c6
ω = 2π * 100u"Hz";

# ╔═╡ 46d486b7-41e1-4331-9ae5-58eb096eaa5f
ω0 = 2π * 120u"Hz";

# ╔═╡ 2b2face7-bb03-481c-9254-2ba7ce5bd3fe
γ = 2π * 10u"Hz";

# ╔═╡ 1009858f-a308-4daf-81a2-8cc73ff8e399
E_0 = 1u"V/m";

# ╔═╡ 757dd90f-700a-4cce-aa87-d71d3353dcd2
x = e/m_e * 1 /(ω0^2 - ω^2 + 2im *  γ * ω) * E_0 |> upreferred

# ╔═╡ 0f9f91ad-ace2-47a9-846d-a9805f5d976f
x_small = e/(2 * m_e * ω0) * 1 /(ω0 - ω + 1im *  γ ) * E_0 |> upreferred

# ╔═╡ 2480ae06-cd44-4fb7-96ce-7a21eda698a0
S = 0.5 * ε_0 * c_0 * E_0^2 |> u"W/m^2"

# ╔═╡ cf992cef-3cb3-47fc-b6ee-20d0dd3dc234
P_abs = e^2/(2* ε_0 * m_e * c_0  ) * γ / ((ω0 - ω)^2 +  γ^2 ) * abs(S) |> u"W"

# ╔═╡ 1e1f7cd9-c8d8-4ae7-b18d-98676d6cdbda
σ_absLorentz = P_abs / abs(S)

# ╔═╡ c6c9daad-7978-4381-88d9-468c87d46213
dω = 1u"Hz";

# ╔═╡ 2460fd43-d02f-4c0e-a519-e6bc4765e2fb
LHS_eq15 = σ_absLorentz  * dω

# ╔═╡ 17420837-b902-445f-a08a-70c437819d15
RHS_eq15 = π * e^2/(2 * ε_0 * m_e * c_0  ) |> u"Hz*m^2"

# ╔═╡ b984254b-58f4-4e36-92fc-7690147fcfae
md"""
## Transition dipole moment
"""

# ╔═╡ f0d93a3a-0fcb-4719-a837-302720c9c698
ρ_E = 1/1u"eV";

# ╔═╡ 4da5c33e-74f3-4d8f-b8bc-6157ab97530e
μ_if = -e * 1e-10u"m";

# ╔═╡ 9e68ebcc-a8a3-4246-b5bf-7cabe4cb9122
Γ16 = 2π / ħ * abs(μ_if * E_0)^2 * ρ_E |> upreferred

# ╔═╡ 52523b12-b087-4fbf-8f17-09d2410ac969
ρ_ω = 1/1u"Hz";

# ╔═╡ 65a55eb5-e497-4687-94db-59988eea5806
Γ23 = π / (2 * ħ^2 ) * E_0^2 * abs(μ_if)^2 * ρ_ω |> u"Hz"

# ╔═╡ f9b56dea-b85b-4efb-b97e-bf98ebaf7e84
u_ω = 1u"J/(Hz*m^3)"

# ╔═╡ b0fa06e5-3efe-4e39-a0de-f78fbe0aa53c
LHS_eq24 = 0.5 * ε_0 * E_0^2  |> u"J/m^3"

# ╔═╡ fa53ad5a-ca69-4c53-8f34-e02d7ee916f2
RHS_eq24 = u_ω * dω

# ╔═╡ 6ffc2729-9544-4444-bb05-8ee8a176c280
Γ25 = π / (ħ^2 * ε_0) * abs(μ_if)^2 * u_ω * ρ_ω * dω |> u"Hz"

# ╔═╡ 37037056-88e9-49f7-8338-481b68d773a2
Γ26 = π / (ħ^2 * ε_0) * abs(μ_if)^2 * u_ω |> u"Hz"

# ╔═╡ 4e30e024-eaa0-4903-ac12-e906e22bf5d3
σ_par_ω = 1u"m^2";

# ╔═╡ b922142e-fae3-4954-ad26-e6655e4a7919
LHS_eq27 = σ_par_ω  * dω |> upreferred

# ╔═╡ 08747360-6c94-40d2-a731-ae6b804961cc
RHS1_eq_27 = ħ * ω0 * Γ26 / (c_0 * u_ω) |> upreferred

# ╔═╡ 55723fd1-217e-4b46-88e9-29240b395611
RHS2_eq_27 = π * ω0  / (ħ * c_0 *  ε_0 )  * μ_if^2 |> upreferred

# ╔═╡ 9ebabe82-a3fb-4201-aaa4-7bc1c0db718a
Lineshape = 1u"1/Hz"

# ╔═╡ 48dc92cc-39c1-414b-a8ad-b71a9162480b
Lineshape * dω

# ╔═╡ 67d86eda-f75d-417f-b91f-44a2810c6f74
σ_par_ω_28 = π * ω0  / (ħ * c_0 *  ε_0 ) * μ_if^2 * Lineshape |> upreferred

# ╔═╡ 609c3d33-754d-494a-971d-cfaf5b14b61f
σ_par_ω_29 = ω0  / (ħ * c_0 *  ε_0 * γ) * μ_if^2  |> upreferred

# ╔═╡ f2c1fe30-bef5-4688-b59b-ba828e00fc18
A_21 = ω0^3  / (3 * π * ħ * c_0^3 *  ε_0) * abs(μ_if)^2  |> upreferred

# ╔═╡ fca35ffe-dadb-47e6-aede-6b3d4e7ff69e
LHS_eq32 = ϵ / ω0 * dω 

# ╔═╡ 64d3666a-fd34-44e0-9dbc-6178bacbb029
RHS_eq32 = π * N_A / (3 * log(10) * ħ * c_0 *  ε_0) * abs(μ_if)^2 |> u"(M*cm)^-1"

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
git-tree-sha1 = "b7e530ab28c9e19bf1742de77badbd3c943541e5"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "2.1.3"

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
# ╟─c91c4202-e11d-11ee-388f-e7bb53c78523
# ╟─1d5ec330-cc57-4c11-9821-05e16a94bd82
# ╠═989a385c-20a8-492e-9183-c0aa2a9e08b0
# ╠═6753972d-e492-43da-967d-708b7cafba2d
# ╟─08a6da7b-3dd6-4492-8660-a40b1854a9e9
# ╠═cb97a656-0952-465a-abad-da0812f4da5e
# ╠═9b63cd47-142d-47c3-9806-1a3a57502984
# ╠═76f3bf56-ab32-490c-a49f-4ad72b1ade0a
# ╠═eec0651f-24fe-4fe5-aba2-679539cf9a3a
# ╠═33e6fc57-e102-4829-ab0f-9787c37666a2
# ╠═425d73f4-e30c-4f02-8b5e-3d9903a3be71
# ╠═63e83264-60d2-4825-a8ef-2b7a19b2093f
# ╟─53d3a3c1-420d-4b00-b580-40f29f4fcd35
# ╠═8ac5281a-5970-45ce-bea8-9409e6ff30c6
# ╠═46d486b7-41e1-4331-9ae5-58eb096eaa5f
# ╠═2b2face7-bb03-481c-9254-2ba7ce5bd3fe
# ╠═1009858f-a308-4daf-81a2-8cc73ff8e399
# ╠═757dd90f-700a-4cce-aa87-d71d3353dcd2
# ╠═0f9f91ad-ace2-47a9-846d-a9805f5d976f
# ╠═2480ae06-cd44-4fb7-96ce-7a21eda698a0
# ╠═cf992cef-3cb3-47fc-b6ee-20d0dd3dc234
# ╠═1e1f7cd9-c8d8-4ae7-b18d-98676d6cdbda
# ╠═c6c9daad-7978-4381-88d9-468c87d46213
# ╠═2460fd43-d02f-4c0e-a519-e6bc4765e2fb
# ╠═17420837-b902-445f-a08a-70c437819d15
# ╟─b984254b-58f4-4e36-92fc-7690147fcfae
# ╠═f0d93a3a-0fcb-4719-a837-302720c9c698
# ╠═4da5c33e-74f3-4d8f-b8bc-6157ab97530e
# ╠═9e68ebcc-a8a3-4246-b5bf-7cabe4cb9122
# ╠═52523b12-b087-4fbf-8f17-09d2410ac969
# ╠═65a55eb5-e497-4687-94db-59988eea5806
# ╠═f9b56dea-b85b-4efb-b97e-bf98ebaf7e84
# ╠═b0fa06e5-3efe-4e39-a0de-f78fbe0aa53c
# ╠═fa53ad5a-ca69-4c53-8f34-e02d7ee916f2
# ╠═6ffc2729-9544-4444-bb05-8ee8a176c280
# ╠═37037056-88e9-49f7-8338-481b68d773a2
# ╠═4e30e024-eaa0-4903-ac12-e906e22bf5d3
# ╠═b922142e-fae3-4954-ad26-e6655e4a7919
# ╠═08747360-6c94-40d2-a731-ae6b804961cc
# ╠═55723fd1-217e-4b46-88e9-29240b395611
# ╠═9ebabe82-a3fb-4201-aaa4-7bc1c0db718a
# ╠═48dc92cc-39c1-414b-a8ad-b71a9162480b
# ╠═67d86eda-f75d-417f-b91f-44a2810c6f74
# ╠═609c3d33-754d-494a-971d-cfaf5b14b61f
# ╠═f2c1fe30-bef5-4688-b59b-ba828e00fc18
# ╠═fca35ffe-dadb-47e6-aede-6b3d4e7ff69e
# ╠═64d3666a-fd34-44e0-9dbc-6178bacbb029
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
